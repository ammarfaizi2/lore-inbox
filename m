Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUHXXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUHXXCf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269101AbUHXW7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:59:43 -0400
Received: from smcc.demon.nl ([212.238.157.128]:57105 "HELO smcc.demon.nl")
	by vger.kernel.org with SMTP id S269096AbUHXW6d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:58:33 -0400
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Organization: I'm not organized
To: Greg KH <greg@kroah.com>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Date: Wed, 25 Aug 2004 00:58:24 +0200
User-Agent: KMail/1.6.1
References: <1092793392.17286.75.camel@localhost> <1092845135.8044.22.camel@localhost> <20040823221028.GB4694@kroah.com>
In-Reply-To: <20040823221028.GB4694@kroah.com>
Cc: Linux USB Mailing List <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408250058.24845@smcc.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tuesday 24 August 2004 00:10, you wrote:
> On Wed, Aug 18, 2004 at 09:05:36AM -0700, Fr?d?ric Detienne wrote:
> > On Tue, 2004-08-17 at 21:38, Andrew Morton wrote:
> > > Fr?d?ric Detienne <fd@cisco.com> wrote:
> > > > I suppose this is not the only place where we
> > > >  prepare API's for modules that do not belong to the kernel tree.
> > >
> > > It _is_ the only place, and that's the problem.
> >
> > yes and no. By providing a hook, there is a chance to insert an other
> > decompressor (hopefully, a reverse engineered, open source one).
>
> Actually, in thinking about this even more, I just realized that I have
> to rip this hook out.  I say this because we are allowing a change to
> the kernel that is needed _only_ for a closed source module.  See
> Linus's comments about "if a change is needed to be made to the kernel
> in order to get a closed source module to work, that module must be made
> opensource" or something close to that.
>
> So, I'll rip this out with the next round of USB patches that I send off
> to Linus.
>
> Nemosoft, any thoughts?

Uhm, excuse me? This hook has been there since the beginning of PWC in the 
kernel, so I don't consider it a 'change'. The only change there has been 
is in the declaration part, to allow for a single type of linkage with an 
external library [*]. Actually, if they hadn't started using "Register 
parameters" in the kernel to squeeze out a a few microseconds, I wouldn't 
have had this problem, and nobody would have noticed. The real problem is 
that GCC 2.95 doesn't like 'asmlinkage' in function pointer declarations 
which is why PWC failed to compile. I was _about_ to create in a patch 
tonight that would solve this problem and make it work on both GCC 2 and 
GCC 3 again, until I read this mail. 

Anyway....

I've just about had it with the increasing 
"we-don't-want-binary-stuff-in-Linux" attitude lately. If you rip out this 
hook for PWC (pwc_register_decompressor), which would make it impossible to 
load a decompressor, closed source *OR* open source (should that happen one 
day), is going to be the last straw.

Without this hook, PWC will work, but with limitations, just as it always 
has. But the _user_ always had a choice of loading a closed source module 
to get the extras. If you, kernel developers, maintainers, etc. are going 
to take away that right from the _users_, I think you're way over head, 
forgetting what open source is about, IMO.

I accept that the Linux kernel is the work of Linus and the maintainers, and 
they can do with it as they please, but I will not accept that they can put 
arbitrary limits on the kernel's use by me, or other users.

I've been maintaining this driver for the past 4 years, and it's always been 
an uphill battle against the closed sourceness of the driver. First, it was 
completely binary, which proved to be quite a support burden but I managed. 
Then I got allowance to open source part of the driver and add it to the 
kernel, so a) the webcam could run on more platforms, b) I could narrow 
down the support issues. Then, I started introducing cross-compiled PWCX 
(decompressor) modules for a variety of platforms, so it would work on even 
more systems. In the mean time, I had to dodge several changes to the 
kernel that, intentionally or unintentionally, caused the PWCX part to 
break down. But I managed. [**] And now, finally with PWC 9, I could 
provide even better cross-platform support. All to get these webcams 
working, make _a lot_ of people happy, and make Linux the top OS it 
deserves to be. Appearantly all in vain.

To come back to Linus´s comment "if a change is needed [...] in order to get 
a closed source module to work, that module must be made opensource". Well, 
that ain't gonna work. There is no way that manufacturers are suddenly 
going to wave their hands in the air and start panicking "Oh dear, we're 
going to loose Linux support! What must we do?! Should we open source? 
Argh!" It is not going to happen. Period. Get down to earth, now.

Actually, I've got a little surprise for you. The NDA I signed with Philips 
has already expired a year ago. Yet, I didn't just throw the decompressor 
code on the Internet. First, there could still be legal remedies since the 
cams are still in production to this very day. Second, that NDA was signed 
on a basis of trust and I do not want to lose that trust. I'm looking at 
the bigger picture here: if we (Linux developers) can show we are 
trustworthy, we may be able to get better support from hardware 
manufacturers now and in the future (and really, that's what the kernel is 
for 75% about ....) I'm still in contact with Philips and who knows, maybe 
we can get all the source opened up...

Anyway, before this gets too long... I'm giving you a choice here. Either:

* you are going to accept that there is a driver in the Linux kernel that 
has a hook that _may_ be used to load a binary-only decompressor part into 
the kernel, at the user's disgression. Maybe, one day, that part will be 
open source too but I cannot guarantuee that. 

* Or, you're saying: no, we cannot allow this under any circumstance. We do 
not even want to provide the means for the theoretical possibility that a 
binary module might be loaded into the kernel (in which case you can scrap 
the whole idea of loadable modules, if you want my opinion)

Those are the options. No more, no less.

In case the answer is "No", then I will:
- demand that the PWC driver is removed from any further Linux kernel 
releases; Open source or not, it's still _my_ work.
- remove the website (http://www.smcc.demon.nl/webcam/), all webpages and 
PWC version available for download from that site.
- shut down the bug-tracker 
- remove the PWC related mailbox from my system
- not respond to ANY mail related to PWC anymore; no user requests, no 
problem solving, no queries for information.

Basicly, the PWC driver will then be null and void. And yes, that is a 
threat, but it shows how fed up I am with this. And believe me, there are a 
lot of users who will NOT be happy. But if you (kernel peeps) show contempt 
for all the work that I have done, then I'm not going to help you anymore, 
with Linux. Simple as that. 

I'm demanding a clear, and unambiguous answer on my question, if need be 
from Linus himself. I think the status of binary-only drivers, or in this 
case, a plugin, has always been in some sort of 'legal' limbo, and that PWC 
has always more or less meandered through the gaps. Now I want to know 
where I'm standing at.

 - Nemosoft

[*] Two different version are possible, but most people would probably not 
have a clue as to how their kernel is compiled; and you won't know until 
the module Oopses...

[**] To the nitwit on /. who once said "Well, you brought that all onto 
yourself when you signed that NDA", I can only say: "Go suck a lemon", to 
quote Maj. Carter. (SG-1)




