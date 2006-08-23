Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWHWIb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWHWIb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWHWIb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:31:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:26121 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964777AbWHWIb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:31:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l6qCzBDpfF7iVU3vaeOQhIqtb4Ddr7y9boI/B6RbaLJWIIxgifGRh1OdtaPR37bNqh2Kfm+mdqt7kZ0u7diikJBU649rWv9bVWo/rmM6j94gMBSAem5js4hHOT1PfdyrQPPR84cIbwuYj5CmJsJKeJ+9bNEGsB8HfPX/iXTmj+E=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Milan Hauth <milahu@googlemail.com>
Subject: Re: Specify devices manually in exotic environment
Date: Wed, 23 Aug 2006 10:31:06 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <op.teo9mqjlepq0rv@localhost>
In-Reply-To: <op.teo9mqjlepq0rv@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231031.07024.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 August 2006 21:26, Milan Hauth wrote:
> Hello there.
> 
> Got a quite exotic environment here -- a Compaq Evo T20 thin client, which  
> I want to run Linux on.
> 
> But I'm not satisfied with a completely thin client, meaning that all the  
> files are located on the server. What I want is the basic system to be  
> located on the client, while the Unix System Resources, for example, are  
> mounted from the server, since they're too big for 32MB of Flash memory.
> 
> The problem I'm facing at the moment is the T20's BIOS, which doesn't seem  
> to pass the device information correctly to the Kernel.

More info? What information is not passed?

> GRUB (v0.97) does   
> work with a workaround, which can be found in the document [1] I followed  
> to 'teach' Linux to the T20.
> 
> I already tried to use /proc/sys/kernel/real-root-dev, but setting the  
> root device to 0x80 (as already specified for GRUB) or 0x81 (1st partition  
> of 0x80) did not seem to help.
> 
> So, did I forget anything when building my Kernel? Or is it just another  
> trick, I don't know yet?
> 
> Hopefully someone here can help me on this one.. have been 'working' on my  
> cute T20 for several months now.. :-\

I just pass two parameters to kernel on the commandline,
then I create needed node (in initrd):

mknod /dev/root b "$ROOTMAJ" "$ROOTMIN"

And then (still in initrd):

mount -n -o ro /dev/root /new_root
mount -n -t ramfs none /new_root/dev
cp -dp /dev/console /dev/null /new_root/dev
cd /new_root
# making sure we dont keep /dev busy
exec <dev/console >dev/console 2>&1
# proc/ in new root is used here as a temp mountpoint for old root
pivot_root . proc
exec chroot . sh -c 'umount -n /proc; exec /bin/env - /sbin/init'

and then proceed as usual (/dev will be populated by udev later)

For this to work you only need to know major/minor#.
--
vda
