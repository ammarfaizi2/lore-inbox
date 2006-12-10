Return-Path: <linux-kernel-owner+w=401wt.eu-S1762517AbWLJUwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762517AbWLJUwd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762514AbWLJUwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:52:33 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:3556 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762491AbWLJUwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:52:33 -0500
Date: Sun, 10 Dec 2006 21:52:30 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: strncpy optimalisation? (lib/string.c)
Message-ID: <20061210205230.GB30197@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Dec 11 21:32:58 CET 2006
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In lib/string.c we have:

char *strncpy(char *dest, const char *src, size_t count)
{
        char *tmp = dest;

        while (count) {
                if ((*tmp = *src) != 0)
                        src++;
                tmp++;
                count--;
        }
        return dest;
}

now I wonder isn't this ineffecient when strlen(src) < count? It would
then, if I'm correct, iterate count-strlen(src) times doing useless
increment/decrement. And since there are aprox. 580 instances in the
2.6.18.2 source, maybe some efficency can be won here.
Wouldn't it be better to do:
                if ((*tmp = *src) == 0x00)
                        break;

So that would be:
--- lib/string.c	2006-11-04 02:33:58.000000000 +0100
+++ string-new.c	2006-12-10 21:50:05.000000000 +0100
@@ -97,8 +97,8 @@
 	char *tmp = dest;
 
 	while (count) {
-		if ((*tmp = *src) != 0)
-			src++;
+		if ((*tmp = *src) == 0x00)
+			break;
 		tmp++;
 		count--;
 	}


Folkert van Heusden

-- 
www.vanheusden.com/multitail - win een vlaai van multivlaai! zorg
ervoor dat multitail opgenomen wordt in Fedora Core, AIX, Solaris of
HP/UX en win een vlaai naar keuze
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
