Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWBXTOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWBXTOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWBXTOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:14:49 -0500
Received: from mx3.mail.ru ([194.67.23.149]:2136 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932428AbWBXTOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:14:49 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: "Ghost" devices in /sys/firmware/edd
Date: Fri, 24 Feb 2006 22:14:34 +0300
User-Agent: KMail/1.9.1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602242214.46290.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have single drive hda; still EDD shows valid and the _same_ MBR signature 
for all possible 16 drives:

{pts/0}% cat /sys/firmware/edd/*/mbr_*
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a
0x7fca3a0a

other attributes are correctly present for the drive 0x80 only.

Not being expert in x86 assembly, but comparing main loops for signature and 
other info:

signature:
        int     $0x13
        sti                     # work around buggy BIOSes
        popw    %dx
        popw    %es
        popw    %bx
        jc      edd_mbr_sig_done                # on failure, we're done.

extended EDD info:

edd_check_ext:
        movb    $CHECKEXTENSIONSPRESENT, %ah    # Function 41
        movw    $EDDMAGIC1, %bx                 # magic
        int     $0x13                           # make the call
        jc      edd_done                        # no more BIOS devices

Is it possible that carry flag is cleared between return from int 0x13 and 
querying for it in the former case? This would perfectly explain that EDD 
does not notice failure of reading sector and simply copies the same 
signature from the very first drive.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFD/1smR6LMutpd94wRAncjAJ0b9wLmKK9V2bc93ghAIUa7dY5VWQCfZ8BP
aiT8y5TX3DE05ZN8wfnfg7E=
=uB1I
-----END PGP SIGNATURE-----
