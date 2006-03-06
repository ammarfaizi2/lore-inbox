Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWCFMs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWCFMs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 07:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWCFMs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 07:48:57 -0500
Received: from mail.avm.de ([194.175.125.228]:8857 "EHLO mail.avm.de")
	by vger.kernel.org with ESMTP id S1750811AbWCFMs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 07:48:57 -0500
In-Reply-To: <20060217230004.GA15492@kroah.com>
Subject: Re[2]: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of
 major vendor excluded
To: Greg KH <greg@kroah.com>
Cc: kkeil@suse.de, libusb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       opensuse-factory@opensuse.org, torvalds@osdl.org
X-Mailer: Lotus Notes Release 6.5.2 June 01, 2004
Message-ID: <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de>
From: s.schmidt@avm.de
Date: Mon, 6 Mar 2006 13:47:43 +0100
X-MIMETrack: Serialize by Router on ANIS1/AVM(Release 6.5.5|November 30, 2005) at
 06.03.2006 13:47:44
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-purgate: clean
X-purgate: This mail is considered clean
X-purgate-type: clean
X-purgate-Ad: Checked for Spam by eleven - eXpurgate www.eXpurgate.net
X-purgate-ID: 149429::060306134747-687B8006-201C5908/0-0/0-1
X-purgate-size: 12257/10772
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.33.1.3; VDF: 6.33.1.70; host: mail.avm.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your focus on the technical aspects shows us that there is a common
understanding, so we certainly appreciate your input.

The described userland/kernel mix scenarios may work in uninterrupted
environments, but non-stop quality of service "at all times and situations"
is only truly feasible in kernel space. "with the only bottleneck being the
CPU to RAM bus." is exactly the main argument against a mixed kernel/user
space driver architecture. We know from our everyday business, Linux is
often used in slow CPU environments like PIII or similar. Thus latency
times are even more critical within these environments.

Even though people might do realtime DSP things in user space with Linux
and soft modems might work pretty well in userspace, in the case of Fax G3
an extremely short latency is required. The user space lacks the required
reliability and interoperability. Latency times of 4/10/20 or 40
milliseconds are one aspect, but QoS is the overall essence. Within the
kernel space there is no need for unnecessary mode switches or data copy
procedures. Compared to other operating systems, such as Mac OS, BeOS,
Windows etc., Linux is walking a solitary path with the "user mode only"
shift. One gets the impression, that legal concerns are leading Linux to a
technically suboptimal/isolated solution.

And referring to the fax4box tool, missing QoS is the reason why we
continue to not provide support for this tool.

Kind Regards
Sven Schmidt

AVM Audiovisuelles Marketing und Computersysteme GmbH
Alt-Moabit 95, 10559 Berlin, Germany
http://www.avm.de



                                                                           
             Greg KH                                                       
             <greg@kroah.com>                                              
             Gesendet von:                                              An 
             linux-kernel-owne          s.schmidt@avm.de                   
             r@vger.kernel.org                                       Kopie 
                                        torvalds@osdl.org, kkeil@suse.de,  
                                        linux-kernel@vger.kernel.org,      
             18.02.2006 00:00           opensuse-factory@opensuse.org,     
                                        libusb-devel@lists.sourceforge.net 
                                                                     Thema 
                                        Re: 2.6.16 serious consequences /  
                                        GPL_EXPORT_SYMBOL / USB drivers of 
                                        major vendor excluded              
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           





First off, thank you for replying to my message.  Hopefully we can all
work together to find a proper solution for everyone here.


On Thu, Feb 16, 2006 at 03:24:44PM +0100, s.schmidt@avm.de wrote:
> The user space does not ensure the reliability of time critical analog
> services like Fax G3 or analog modem emulations. This quality of service
> can only be guaranteed within the kernel space.

What about a mix of userspace/kernelspace?

> Let me explain that issue using the FaxG3-service as an example. Fax G3
> (T.30) is not specified as a data protocol with error-free transmission.
> Let us assume, there is a system peak demand on the host system, while a
> fax is incoming, e.g. because of a parallel access of a higher
prioritized
> process. Handled in user mode, the user gets broken or fragmented faxes
as
> a result. Same for the communication with analogue remote stations
(modems)
> over a digital net (ISDN). You cannot speak about reliable quality of
> service anymore. Only the kernel offers low latency and timeline
processing
> which is required for soft DSP alike processing. This should be OS
> independent and from our point of view, Linux should not be inferior to
any
> other OS.

I don't want it to be "inferior" in any way either.  And I don't think
it is.  Right now, we have the highest throughput of any operating
system for USB bandwidth.  And that is measured by a userspace program
using usbfs directly, no kernel driver needed.  We can easily keep up
with a full datastream on the USB bus with no problems of dropped frames
or other issues.

It's also been proven recently that Linux can, with a mix of userland
libraries and tiny kernel drivers, fill a 10gbit ethernet pipe, with the
only bottleneck being the CPU to RAM bus.  So claims that putting stuff
in userland will cause quality of service issues is pretty unlikely.

Again, how about a mix of a kernel driver that handles the buffering of
the data, and any proper acknowledgment needed, and userspace handling
the heavy lifting of decoding the fax/image data?

For an example, the ldusb driver handles high speed data acquisition
devices, and buffers the data until userspace can flush the buffers.
This makes for a very tiny and simple kernel driver, and all of the
"secret" logic can be done in userspace.

> Of course, other OS also have the concept of shifting usb drivers to user
> space, but time critical demands are explicitly excluded. The given
> examples gPhoto und rio500 at
> http://libusb.sourceforge.net/doc/examples-other.html operate mostly
> unidirectionally. Isochronical services within the libusb, especially the
> USB driver framework for the user mode are not ready for bidirectional
> operation. Even though the current libusb development started integrating
> the isochronous transfer support, it still is under construction and it
is
> unclear if this task can be accomplished at all (see statement from
> Johannes Erdfelt at
>
http://sourceforge.net/mailarchive/forum.php?thread_id=9531397&forum_id=5425

> ).

I don't see Johannes saying that things aren't going to be accomplished
in that post.  Perhaps you meant to point to some other message?

Anyway, libusb is a nice, friendly wrapper around usbfs.  But if you
really want to get speed and full control over your device, just use
usbfs directly.  That's what all of the applications that I know of that
do complex, high speed things do.

And yes, usbfs is showing it's age.  It's been around since 2.3 days and
has not really been modified since then.  Numerous people have discussed
creating a usbfs2, in the format that gadgetfs is in (async io for
endpoints), and any help in designing and implementing it, so that it
meets your needs would be greatly appreciated.  I've already started the
basic framework for it, if you are interested.  I'll post it on the
linux-usb-devel mailing list next week (early looks can be found at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6
/patches/usb/usbfs2.patch
)

> In contrast, AVM's driver concept is established for many years now. So
the
> user mode does not seem to be an alternative for ISDN/DSL communication
> devices at the moment.

I know of at least 2 diffeent ISDN devices that work just fine using
usbfs.  So for you to say it's not possible is not a fair statement.

> Moreover, a rework of more than 30 devices would consume a lot of
> development resources. You will hardly find a similiar company
> situation. We are not talking about a 10 to 20kByte mouse driver, but
> rather >600kByte of complex work per device. Take a look at the
> FRITZ!Card PCI package
>
atftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.93/fcpci-suse93-3.11-07.tar.gz).


That seems _very_ large for a Linux kernel driver.  None of the existing
Linux USB drivers even come close to that size.  I'm sure we can find
some stuff in there to push out to userspace based on the size alone :)

> As a private corporation our primary focus is market relevance. AVM
> invested more than 10 years of work to make analog services like Fax G3
and
> analog modem emulation available to users of the digital ISDN network.
The
> situation is similar for the DSL part of the driver with very complex DSP
> algorithms. To anticipate any "open vs. closed source" discussion:Only a
> handful of companies worldwide have such know-how. With regard to our
> competitive situation, we have to protect our hard-won intellectual
> property and therefore cannot open the closed source part of the driver.

I'm glad that you focused on the technical aspects of the issue, and I
would like to keep the discussion there.

However I do just have one final thing to say about this.  You mention
that you have to protect your "hard-won intellectual property".  I fully
understand this, and respect your wishes.  However you also need to
respect our (the Linux Kernel developers) intellectual property rights.
We released our code under the GPL, which states in very specific form,
exactly what your rights are when using this code.  When you link other
code into our body of code, you are obligated by the license, to also
release your code under this same license (when you distribute it).

As an example, if a Linux kernel developer were to take your code, and
violate your license and drop it into a GPL licensed body of work
without your permission, you would rightfully be incensed, and work to
stop this from happening.  Perhaps you would take legal action, along
with public notice of the act.  And you would be fully within your right
to do so.

So, when you take the Linux kernel code, and link with it (or even build
with it's header files and inline functions), and not abide by our well
documented licenses, you can understand why a number of us would be
upset and work to address this issue.  Some of the kernel developers are
employing legal means (cease-and-desist letters, lawsuits, etc.) while
others are working for a technological solution to this legal issue
(EXPORT_SYMBOL_GPL, etc.)

I've had the misfortune of discussing this issue with many different IP
lawyers over the years, and all of them are unanimous in saying that
they do not feel there is any legal way for anyone to distribute a
closed source Linux kernel module at all these days.  That is based on a
deep understanding of the GPL, IP law in general, and the statements of
numerous Linux kernel developers over the past few years.

It seems that Linux distributions also realize this issue, and a number
of them now refuse to ship non-GPL kernel modules, because of this.

I say all of this, not to upset you, but to try to give you an idea of
why people are so concerned when they are confronted with closed source
Linux kernel modules.  You are violating our license, while at the same
time asking that the world abide by your license.  The irony is deep...

Anyway, in the end, it's up to you to decide if you have a business case
for supporting Linux or not.  No one is forcing you to do so.  If you do
not want to create any Linux drivers for your hardware, that is your
right, and fine with us (some of your customers might be upset, but
that's your decision...)

But if you do wish to support Linux, then you must abide by the license
that the kernel is released under.  To not do so is a blatant disregard
for the intent and wishes of the developers.

On a personal note, I am very glad to continue this discussion on a
technical level, and work together with you on how to best solve the
usbfs userspace / kernelspace issue for your products so that you can
create a solution that is acceptable both for your customers, and for
the Linux kernel community.

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


