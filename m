Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162221AbWKPCqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162221AbWKPCqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162248AbWKPCqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:46:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:65167 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162243AbWKPCp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:45:56 -0500
Message-Id: <20061116024644.378758000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Sergey Vlasov <vsu@altlinux.ru>,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: [patch 15/30] Input: psmouse - fix attribute access on 64-bit systems
Content-Disposition: inline; filename=input-psmouse-fix-attribute-access-on-64-bit-systems.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Sergey Vlasov <vsu@altlinux.ru>

psmouse_show_int_attr() and psmouse_set_int_attr() were accessing
unsigned int fields as unsigned long, which gave garbage on x86_64.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/input/mouse/psmouse-base.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

 The problem was found in 2.6.18.2; the same patch applies to the
 current tree.

--- linux-2.6.18.2.orig/drivers/input/mouse/psmouse-base.c
+++ linux-2.6.18.2/drivers/input/mouse/psmouse-base.c
@@ -1332,20 +1332,22 @@ ssize_t psmouse_attr_set_helper(struct d
 
 static ssize_t psmouse_show_int_attr(struct psmouse *psmouse, void *offset, char *buf)
 {
-	unsigned long *field = (unsigned long *)((char *)psmouse + (size_t)offset);
+	unsigned int *field = (unsigned int *)((char *)psmouse + (size_t)offset);
 
-	return sprintf(buf, "%lu\n", *field);
+	return sprintf(buf, "%u\n", *field);
 }
 
 static ssize_t psmouse_set_int_attr(struct psmouse *psmouse, void *offset, const char *buf, size_t count)
 {
-	unsigned long *field = (unsigned long *)((char *)psmouse + (size_t)offset);
+	unsigned int *field = (unsigned int *)((char *)psmouse + (size_t)offset);
 	unsigned long value;
 	char *rest;
 
 	value = simple_strtoul(buf, &rest, 10);
 	if (*rest)
 		return -EINVAL;
+	if ((unsigned int)value != value)
+		return -EINVAL;
 
 	*field = value;
 

--
