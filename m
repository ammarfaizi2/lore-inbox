Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281930AbRKUQ7K>; Wed, 21 Nov 2001 11:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281917AbRKUQ6u>; Wed, 21 Nov 2001 11:58:50 -0500
Received: from ns0.dhm-systems.de ([195.126.154.163]:47624 "EHLO
	ns0.dhm-systems.de") by vger.kernel.org with ESMTP
	id <S281904AbRKUQ6l>; Wed, 21 Nov 2001 11:58:41 -0500
Message-ID: <3BFBDD32.434AB47B@web-systems.net>
Date: Wed, 21 Nov 2001 17:58:26 +0100
From: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Reply-To: Ado.Arnolds@dhm-systems.de
Organization: DHM GmbH & Co. KG
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: de, en, fr, ru
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: fs/exec.c and binfmt-xxx in 2.4.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Hi Alan, Hi all,

I have a problem with loading modules for binary formats. The
reason for this problem shows up in fs/exec.c search_binary_handler().

Starting with linux-2.1.23 (and up to 2.4.14) there was a change
in the format and offset of printing the magic number for requesting
a handler module. Up to 2.1.22 the statement

    sprintf(modname, "binfmt-%hd", *(unsigned short *)(&bprm->buf[0]));
                              ^^                                 ^^^

was used. Now, and up to 2.4.14, the statement is:

    sprintf(modname, "binfmt-%04x", *(unsigned short *)(&bprm->buf[2]));
                              ^^^                                 ^^^

This leads to a request for loading a module which doesn't exist.
Additionally the request is now done with a hex number but modprobe
expects decimal numbers.

>From modutils-2.4.12/util/alias.h:

    ...
    "binfmt-267 binfmt_aout",
    ...
    "binfmt-332 iBCS",
    ...

When i now try to start an older binary in a.out format, which has a
magic number of 0x010b0064, it is translated with the 'new' code to a
request for "binfmt-0064" instead of "binfmt-267" as expected and
properly handled by modprobe.

Another example: for an old COFF executable with magic number
0x014c0004 the generated request is "binfmt-0004" instead of the
correct value "binfmt-332".

Wouldn't it be appropriate to revert the changes to format "%hd"
and use buffer offset 0 again?

Thanks a lot for your help and many greetings from Cologne, Germany

Ado

-- 
------------------------------------------------------------------------
  Heinz-Ado Arnolds                        Ado.Arnolds@web-systems.net
  Websystems GmbH                              +49 2234 1840-0 (voice)
  Max-Planck-Strasse 2, 50858 Koeln, Germany   +49 2234 1840-40  (fax)
