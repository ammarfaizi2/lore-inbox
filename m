Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUJDNmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUJDNmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUJDNmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:42:24 -0400
Received: from open.hands.com ([195.224.53.39]:26537 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267449AbUJDNmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:42:18 -0400
Date: Mon, 4 Oct 2004 14:53:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: 274860@bugs.debian.org
Cc: linux-kernel@vger.kernel.org, 274867@bugs.debian.org
Subject: Re: Bug#274860: Acknowledgement (kernel-image-2.6.8-1-686: CDROM_SEND_PACKET ioctls only work as root)
Message-ID: <20041004135326.GA20930@lkcl.net>
References: <E1CES9w-0005Lh-6f@lkcl.net> <handler.274860.B.10968930694757.ack@bugs.debian.org> <20041004131014.GF19341@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004131014.GF19341@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

found it.

it's a new piece of kernel code verify_command in
drivers/block/scsi_ioctl.c, which checks for the capability
CAP_SYS_RAWIO.

ah, dammit.

for k3b to work, you'd have to install it setuid root, call
getcap(), remove all but the necessary capabilities (i.e. don't
remove CAP_SYS_RAWIO), do a setfsuid() and setfsgid() and do
a setcap().

fuse (file system in userspace) uses this technique for allowing
mount and unmount but nothing else

[which doesn't work on 2.6.8 btw: the getcap() fails, but i did notice
that debian doesn't install fusermount as setuid to root which is half
the problem...]

l.

On Mon, Oct 04, 2004 at 02:10:14PM +0100, Luke Kenneth Casson Leighton wrote:
> additional info:
> 
> kernel 2.6.8.  ioctl ("/dev/hdc", CDROM_SEND_PACKET, cmd)
> 
> commands that are failing as non-root, even when permission is granted
> rwxrwxrwx to /dev/hdc, are, according to some debug info added to k3b:
> 
> 	GET CONFIGURATION (46)
> 	error code: 0
> 	sense key: NO SENSE (2)
> 	asc: 0
> 	ascq: 0
> 
> and:
> 
> 	MODE SELECT (55)
> 	error code: 0
> 	sense key: NO SENSE (2)
> 	asc: 0
> 	ascq: 0
> 
> the result is that k3b cannot determine that the drive exists, therefore
> it cannot use it even though cdrecord might actually work.
> 
> 
> as root, the following errors occur:
> 
> 	MODE SELECT (46)
> 	errorcode: 70
> 	sense key: ILLEGAL REQUEST (5)
> 	asc: 26
> 	ascq: 0
> 
> 	READ DVD STRUCTURE (ad)
> 	errorcode: 70
> 	sense key: NOT READY (2)
> 	asc: 3a
> 	ascq: 0
> 
> presumably it can be concluded that the GET CONFIGURATION ioctl command
> is the one at fault.
> 
> ... what gives?
> 
> l.
> 
> -- 
> --
> Truth, honesty and respect are rare commodities that all spring from
> the same well: Love.  If you love yourself and everyone and everything
> around you, funnily and coincidentally enough, life gets a lot better.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
> 
> -- 
> --
> Truth, honesty and respect are rare commodities that all spring from
> the same well: Love.  If you love yourself and everyone and everything
> around you, funnily and coincidentally enough, life gets a lot better.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
> 

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

