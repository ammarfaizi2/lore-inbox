Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWEDUk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWEDUk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWEDUk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:40:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:11530 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030320AbWEDUk1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:40:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ASW/JSlebJ7nny9VcoPWnylnSvOoFdgZWDTtUDlQV2fTR/vcH3zqj3v/s+LUYOTdKj5VMeqV5mS/3LbCRILEgQP55/A6qL8sxEaLbjE99BejpZpkGk+ALYWlBOdROdYvhGHwlpY8c6Lh+itTFwe55Zc4TAsGt9enIc1PWH1aNTc=
Message-ID: <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
Date: Thu, 4 May 2006 16:40:26 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matthew Garrett" <mgarrett@chiark.greenend.org.uk>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Dave Airlie" <airlied@linux.ie>, "Andrew Morton" <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org, pjones@redhat.com,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>
> > There's already a "rom" file in sysfs.  Could vbetool and friends
> > use that?
>
> Not if you have multiple graphics cards.

Not true, the rom attribute maps the ROM into PCI space where ever the
kernel tells it to and reads it from there. It is the PCI VGA
emulation feature that forces the ROM to appear at C000:0. You can
have the ROM mapped and VGA emulation turned off.

This brings up another major point. X changes the PCI VGA emulation
routing from user space, another thing that it should not be doing. I
have posted patches before providing a sysfs VGA attribute on class
VGA devices. By setting the attribute to 1 you can control the active
VGA emulation device.

This is yet another way that user space can mess up the kernel. If VGA
routing is changes under fbdev (my attribute notifies fbdev, the fbdev
code for processing the notification did get checked in) then the
console will screw up. The usual screw up is that the console goes
blank because hardware fonts are not setup correctly on the new
console.

I also remember posting a patch for initializing all class VGA devices
at boot. This is a complication process since running the ROM will
leave that card as the active VGA device.  The initialization code
made sure to set the console back to the original VGA card after the
secondary one was initialized.  The initialization process needs to
run a user space app which provides real mode access or an x86
emulator. BenH has the x86 emulator code (people sticking PC hardware
into PowerPCs need the emulator). This code for running the ROM should
go into the kernel tree and work with klibc.

I would really like to see a well designed, comprehensive plan for
handling these issues instead of just providing convenience APIs (that
may be hard to get rid of) for the old X code. I'm willing to help if
people really are serious about fixing the problems.

I wrote down a lot of my thoughts on this area in the State of Linux
Graphics article last summer. There is a large section about kernel
issues.
http://people.freedesktop.org/~jonsmirl/graphics.html

>
> > How do vbetool and X coordinate their usage of "enable"?
>
> vbetool won't run at anything other than a text console, and X won't
> mess with the graphics card if it's not on the current VT. You can mess
> this up if you try hard enough (multihead, for instance) but by and
> large it's a situation that you can avoid.
>
> > What if we throw an in-kernel VGA driver into the mix?  But I guess
> > Jon has asked all these questions before; I just didn't get warm
> > fuzzies that there were safe, maintainable answers.
>
> This probably isn't the right long-term answer, but the right long-term
> answer is going to be a very long time away. It's an improvement over
> what we have now. I certainly don't intend to leave vbetool relying on
> it - of course, the "right" answer is for graphics drivers to know how
> to program cards from scratch so we can get rid of vbetool altogether,
> but I'll probably be more concerned about getting my flying car to meet
> new emission standards than I will be by graphics cards at that stage.
>
> --
> Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Jon Smirl
jonsmirl@gmail.com
