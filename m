Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVIULXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVIULXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 07:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVIULXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 07:23:05 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:16501 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750817AbVIULXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 07:23:04 -0400
Message-ID: <43314242.1050802@emc.com>
Date: Wed, 21 Sep 2005 07:21:38 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gmaxwell@gmail.com
CC: Hans Reiser <reiser@namesys.com>, vitaly@thebsh.namesys.com,
       "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>	 <20050921000425.GF6179@thunk.org> <4330A8F2.7010903@emc.com>	 <4330ACE2.8000909@namesys.com> <4330B388.8010307@emc.com>	 <4330CDF1.4050902@namesys.com> <e692861c05092021552d39cecc@mail.gmail.com>
In-Reply-To: <e692861c05092021552d39cecc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.21.6
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_419_BADTHINGS 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

>On 9/20/05, Hans Reiser <reiser@namesys.com> wrote:
>  
>
>
>Another goal of the group should be to formulate a requested set of
>changes or extensions to the makers of drives and other storage
>systems.  For example, it might be advantageous to be able to disable
>bad block relocation and allow the filesystem to perform the action. 
>The reason for this is because relocates slaughter streaming read
>performance, but the filesystem could still contiguously allocate
>around them...
>
>  
>
I think that would be a bad idea - that is how drives used to work and 
it made the higher level file system code handle odd stuff.

In the field, what we tend to see is that drives that accumulate more 
than a very small percentage of bad blocks (say 100 out of many 
millions) tend to be on their way out and need replacing.

>Perhaps a more implementable alternative is just a method to find out
>which sectors have been relocated so the data can be moved off of them
>and they be avoided. (and potentially they be 'derelocated' to
>preserve the relocation space)
>  
>
I think that this kind of information is already at hand via smart, 
etc.  You could write an application to query this data base, but to do 
the reverse mapping from block number to file is not easy (i.e., you 
need to fibmap each file in the file system in order to construct the 
mapping).

>Ditto for other layers.. if a filesystem has some internal integrity
>function and a raid sweep has found that the parity doesn't agree, it
>would be nice if the FS could check all possible decodings and see if
>there is one that is more sane than all the others... This is even
>more useful when you have raid-6 and there is a lot more potential
>decoding.
>  
>
One thing we do on our boxes is to run a sweep program that does a 
"read-verify" command that allows us to flag bad sectors on the platter 
without transferring data, polluting caches, etc.  A second, repair 
phase goes in and pokes at the suspect sectors trying to force a remap.  
If you have the original data (as in the raid case), you can rewrite the 
sector and all is well.  If not, you need to unmount, re-fsck and try to 
revalidate the contents of individual files (this is where the digital 
signatures comes in handy).

>Also things like bubbling up to userspace.. If there is an
>unrecoverable read error in a file found during operation or an
>automated scan, it should show up in syslog with some working complete
>path to the file (as canonical as the fs can provide), and hopefully
>an offset to the error. Then my package manager could see if this is a
>file replaceable out of a package or if it's user data... If it's user
>data, my backup scripts can check the access time on the file and
>silently restore it from backup if the file hasn't changed. ... only
>leaving me an email "Dear operator, I saved your butt yet again
>--love, mr computer"
>  
>
Good idea, but we don't have that reverse mapping at hand for most file 
systems.

>And finally operator policy.. I'd like corrupted user files to become
>permission denied until I run some command to make the accessible,
>don't let me hang my apps trying to access them..
>  
>

