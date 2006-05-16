Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWEPIPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWEPIPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWEPIPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:15:38 -0400
Received: from smtpout.mac.com ([17.250.248.174]:20450 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751675AbWEPIPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:15:38 -0400
In-Reply-To: <20060516025003.GC18645@rhun.haifa.ibm.com>
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com> <1147732867.26686.188.camel@localhost.localdomain> <20060516025003.GC18645@rhun.haifa.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Day <imipak@yahoo.com>,
       linux-kernel@vger.kernel.org, Zvika Gutterman <zvi@safend.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: /dev/random on Linux
Date: Tue, 16 May 2006 04:15:19 -0400
To: Muli Ben-Yehuda <muli@il.ibm.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 15, 2006, at 22:50, Muli Ben-Yehuda wrote:
> On Mon, May 15, 2006 at 11:41:07PM +0100, Alan Cox wrote:
>> A paper by people who can't work out how to mail linux-kernel or  
>> vendor-sec, or follow "REPORTING-BUGS" in the source,
>
> Zvi did contact Matt Mackall, the current /dev/random maintainer,  
> and was very keen on discussing the paper with him. I don't think  
> he got any response.

So he's demanding that one person spend time responding to his  
paper?  The "maintainer" for any given piece of the kernel is the  
entry in MAINTAINERS *and* linux-kernel@vger.kernel.org *and* the  
appropriate sub-mailing-list.  If you want a quick response, it's  
typically correct to CC all 2 or 3, although that certainly doesn't  
guarantee one if people find your emails rude or unhelpful.

>>> I know there have been patches around for ages to improve the  
>>> entropy of the random number generator, but how active is work on  
>>> this section of the code?
>>
>> Going through the claims
>>
>> I would dismiss 2.2 for the cases of things like Knoppix because  
>> CDs introduce significant randomness because each time you boot  
>> the CD is subtly differently positioned. The OpenWRT case seems  
>> more credible. The hard disk patching one is basically irrelevant,  
>> at that point you already own the box and its game over since you  
>> can just do a virtualization attack or patch the OS to record  
>> anything you want.

Any system with a cycle counter has a vast amount of entropy  
available by the time the system even gets through the BIOS.  Various  
things like memory timing, power initialization, BIOS tests, etc are  
all sufficiently variable in terms of CPU clock cycles that the value  
of the cycle counter at the first bootloader instruction executed has  
several bits of randomness.  By the time the bootloader has  
optionally waited for user input and loaded the kernel off the disk,  
chaotic variability in the disk access for HDDs, CDROMs, etc will  
make many bits of the cycle counter sufficiently random.  At that  
point there's a decently random seed, especially once you start  
getting further-randomized cycle-counter-based disk interrupts.  I  
believe there was a paper that discussed how air turbulence in a disk  
drive was sufficient on a several hundered MHz CPU to provide lots of  
entropy per interrupt from the cycle counter alone.

This is totally untrue for an embedded flash-based system; but for  
such a system the only way to get any kind of entropy at all is with  
a hardware RNG anyways, so I don't really see this as being a problem.

I was unsure about the purported forward-security-breakage claims  
because I don't know how to validate those, but I seem to recall  
(from personal knowledge and the paper) that the kernel does an SHA1  
hash of the contents of the pool and the current cycle-counter when  
reading, uses that as input for the next pool state and returns it  
as /dev/random output.  Since the exact cycle-counter value is never  
exposed outside the kernel and only a small window of the previous  
pool state is exposed, I don't see how you could compute an SHA1  
preimage that would reveal a significant portion of the previous  
pool's state, especially given that the best known attack against  
SHA1 is an extremely hard first-preimage attack which only gets a  
single possible preimage, not the set of all possible preimages as  
required to break the kernel algorithm.

>> 2.3 Collecting Entropy
>>
>> Appears to misdescribe the behaviour of get_random_bytes. The  
>> authors description is incorrect. The case where cycle times are  
>> not available is processors lacking TSC support (pre pentium).  
>> This is of course more relevant for some embedded platforms which  
>> do lack cycle times and thus show the behaviour described. There  
>> are some platforms that therefore show the properties they are  
>> commenting on so it is still a relevant discussion in those cases.

Agreed.  I talked to this some above.

>> 3.4 Security Engineering
>>
>> The denial of service when no true entropy exists is intentional  
>> and long discussed. User consumption of entropy can be controlled  
>> by conventional file permissions, acls and SELinux already, or by  
>> a policy daemon or combinations thereof. It is clearly better to  
>> refuse to give out entropy to people than to give false entropy.

Agreed.  If you really want to secure random-number-generation from  
userspace, make a userspace daemon that opens a /dev/user_random  
socket and uses a private root-only /dev/random device.  Then  
implement user quotas and such on the socket; requiring credential- 
passing or whatever other security mechanism you require.  Then you  
can even have the daemon read from /dev/hwrng and from user data  
sources and verify the randomness of the input data before sending it  
to the kernel.  None of that is the kernel's business and could be  
more securely and efficiently done in userspace.

Likewise the talk in the paper about shipping a daemon with the  
kernel is bogus; people will use whatever daemons they want to.  If  
it really matters for your system and the kernel doesn't provide a  
good enough interrupt-based RNG, then you should use one of the many  
available RNG daemons (or write your own) based on your exact  
requirements.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Schulz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Schulz


