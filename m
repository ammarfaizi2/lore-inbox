Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUJDNbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUJDNbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUJDNbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:31:03 -0400
Received: from zork.zork.net ([64.81.246.102]:1774 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S267405AbUJDNaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:30:06 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
References: <20041004130941.GE19341@lkcl.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	linux-kernel@vger.kernel.org
Date: Mon, 04 Oct 2004 14:30:03 +0100
In-Reply-To: <20041004130941.GE19341@lkcl.net> (Luke Kenneth Casson Leighton's
	message of "Mon, 4 Oct 2004 14:09:42 +0100")
Message-ID: <6u4qlaehlw.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton <lkcl@lkcl.net> writes:

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

CDROM_SEND_PACKET calls down to sg_io, which calls verify_command,
which will not permit anyone but root to use any unrecognised
commands.  GET CONFIGURATION does not seems to be one of those
recognised.  This check for unrecognised commands is a fairly recent
addition, IIRC.
