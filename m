Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSKETYo>; Tue, 5 Nov 2002 14:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSKETYo>; Tue, 5 Nov 2002 14:24:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:10515 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265132AbSKETYm>;
	Tue, 5 Nov 2002 14:24:42 -0500
Date: Tue, 5 Nov 2002 20:30:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjanv@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105193004.GA2872@mars.ravnborg.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjanv@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de> <1036520436.4791.114.camel@irongate.swansea.linux.org.uk> <20021105181431.GB3515@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105181431.GB3515@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 07:14:31PM +0100, Jens Axboe wrote:
> I'll write the script, just a damn shame that this feature is gone now.
> .config editing is less powerful now.
The following patch should make most garbage, such as =n, result in
# CONFIG_FOO is not set
without any user confirmation.

Roman - the code uses "//" for comments. Thats not usual kernel style.

	Sam

===== confdata.c 1.1 vs edited =====
--- 1.1/scripts/kconfig/confdata.c	Wed Oct 30 02:16:44 2002
+++ edited/confdata.c	Tue Nov  5 20:25:59 2002
@@ -147,14 +147,28 @@
 			}
 			switch (sym->type) {
 			case S_BOOLEAN:
-				sym->def = symbol_yes.curr;
-				sym->flags &= ~SYMBOL_NEW;
+				if (p[0] == 'y') {
+					sym->def = symbol_yes.curr;
+					sym->flags &= ~SYMBOL_NEW;
+				}
+				else
+				{
+					sym->def = symbol_no.curr;
+					sym->flags &= ~SYMBOL_NEW;
+					continue;
+				}
 				break;
 			case S_TRISTATE:
 				if (p[0] == 'm')
 					sym->def = symbol_mod.curr;
-				else
+				else if (p[0] == 'y')
 					sym->def = symbol_yes.curr;
+				else
+				{
+					sym->def = symbol_no.curr;
+					sym->flags &= ~SYMBOL_NEW;
+					continue;
+				}
 				sym->flags &= ~SYMBOL_NEW;
 				break;
 			case S_STRING:
