Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbQKNJ3z>; Tue, 14 Nov 2000 04:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQKNJ3p>; Tue, 14 Nov 2000 04:29:45 -0500
Received: from ns.caldera.de ([212.34.180.1]:27659 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129469AbQKNJ3c>;
	Tue, 14 Nov 2000 04:29:32 -0500
Date: Tue, 14 Nov 2000 09:59:22 +0100
From: Olaf Kirch <okir@caldera.de>
To: Michal Zalewski <lcamtuf@DIONE.IDS.PL>
Cc: BUGTRAQ@SECURITYFOCUS.COM, linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse.
Message-ID: <20001114095921.E30730@monad.caldera.de>
In-Reply-To: <Pine.LNX.4.21.0011132040160.1699-100000@ferret.lmh.ox.ac.uk> <Pine.LNX.4.21.0011132352550.31869-100000@dione.ids.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011132352550.31869-100000@dione.ids.pl>; from lcamtuf@DIONE.IDS.PL on Tue, Nov 14, 2000 at 12:06:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 12:06:32AM +0100, Michal Zalewski wrote:
> Maybe I am missing something, but at least for me, modprobe
> vulnerabilities are exploitable via privledged networking services,
> nothing more.

Maybe not. ncpfs for instance has an ioctl that seems to allow
unprivileged users to specify a character set (codepage in m$speak)
that's requested via load_nls(), which in turn does a

	sprintf(buf, "nls_%s", codepage);
	request_module(buf);

Yummy.

The vfat file system contains code to obtain the charset name from
the media. Currently, the charset name is always "cp<number>", but
who knows, maybe next month will see another Microsoft extension to
ISO9660 that lets you specify an NLS name as a string?

Everyone is fixing modutils right now. Fine, but what about next
year's modutils rewrite?

This is why I keep repeating over and over again that we should make
sure request_module _does_not_ accept funky module names. Why allow
people to shoot themselves (and, by extension, all other Linux users
out there) in the foot?

Olaf

PS: The load_nls code tries to check for buffer overflows, but
    gets it wrong:

	struct nls_table *nls;
	char	buf[40];

	if (strlen(charset) > sizeof(buf) - sizeof("nls_"))
		fail;
	sprintf(buf, "nls_%s", charset);

    This will accept charset names of up to 35 characters,
    because sizeof("nls_") is 5. This gives you a single NUL byte
    overflow. Whether it's dangerous or not depends on whether your
    compiler reserves stack space for the *nls pointer or not...

-- 
Olaf Kirch         |  --- o --- Nous sommes du soleil we love when we play
okir@monad.swb.de  |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
okir@caldera.de    +-------------------- Why Not?! -----------------------
         UNIX, n.: Spanish manufacturer of fire extinguishers.            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
