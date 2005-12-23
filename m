Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbVLWUfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVLWUfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbVLWUfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:35:16 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:28760 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161042AbVLWUfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:35:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=OouKvKzIt+MSX5A31js9+MG9/L/FXK23KAv/JCt5JTErLf44pXZ/KDb0SYIAGRFmRXfBGGYUE+C/+y3B1CNxpnAFciH29D8iHgOXaQ1srZiOgASX+zkgubHX+tLlAKxTnyxm0vky+xtSMHgurWyfTrzsTP8ahS0wyHsVV1sdse4=
Date: Fri, 23 Dec 2005 23:51:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/pcmcia/cistpl.c: fix endian warnings
Message-ID: <20051223205108.GA15271@mipter.zuzino.mipt.ru>
References: <20051222101523.GP27946@ftp.linux.org.uk> <20051223093146.GT27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223093146.GT27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/pcmcia/cistpl.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -463,7 +463,7 @@ static int follow_link(struct pcmcia_soc
 	/* Get indirect link from the MFC tuple */
 	read_cis_cache(s, LINK_SPACE(tuple->Flags),
 		       tuple->LinkOffset, 5, link);
-	ofs = le32_to_cpu(*(u_int *)(link+1));
+	ofs = le32_to_cpu(*(__le32 *)(link+1));
 	SPACE(tuple->Flags) = (link[0] == CISTPL_MFC_ATTR);
 	/* Move to the next indirect link */
 	tuple->LinkOffset += 5;
@@ -671,8 +671,8 @@ static int parse_checksum(tuple_t *tuple
     if (tuple->TupleDataLen < 5)
 	return CS_BAD_TUPLE;
     p = (u_char *)tuple->TupleData;
-    csum->addr = tuple->CISOffset+(short)le16_to_cpu(*(u_short *)p)-2;
-    csum->len = le16_to_cpu(*(u_short *)(p + 2));
+    csum->addr = tuple->CISOffset+(short)le16_to_cpu(*(__le16 *)p)-2;
+    csum->len = le16_to_cpu(*(__le16 *)(p + 2));
     csum->sum = *(p+4);
     return CS_SUCCESS;
 }
@@ -683,7 +683,7 @@ static int parse_longlink(tuple_t *tuple
 {
     if (tuple->TupleDataLen < 4)
 	return CS_BAD_TUPLE;
-    link->addr = le32_to_cpu(*(u_int *)tuple->TupleData);
+    link->addr = le32_to_cpu(*(__le32 *)tuple->TupleData);
     return CS_SUCCESS;
 }
 
@@ -702,7 +702,7 @@ static int parse_longlink_mfc(tuple_t *t
 	return CS_BAD_TUPLE;
     for (i = 0; i < link->nfn; i++) {
 	link->fn[i].space = *p; p++;
-	link->fn[i].addr = le32_to_cpu(*(u_int *)p); p += 4;
+	link->fn[i].addr = le32_to_cpu(*(__le32 *)p); p += 4;
     }
     return CS_SUCCESS;
 }
@@ -789,10 +789,10 @@ static int parse_jedec(tuple_t *tuple, c
 
 static int parse_manfid(tuple_t *tuple, cistpl_manfid_t *m)
 {
-    u_short *p;
+    __le16 *p;
     if (tuple->TupleDataLen < 4)
 	return CS_BAD_TUPLE;
-    p = (u_short *)tuple->TupleData;
+    p = (__le16 *)tuple->TupleData;
     m->manf = le16_to_cpu(p[0]);
     m->card = le16_to_cpu(p[1]);
     return CS_SUCCESS;
@@ -1093,7 +1093,7 @@ static int parse_cftable_entry(tuple_t *
 	break;
     case 0x20:
 	entry->mem.nwin = 1;
-	entry->mem.win[0].len = le16_to_cpu(*(u_short *)p) << 8;
+	entry->mem.win[0].len = le16_to_cpu(*(__le16 *)p) << 8;
 	entry->mem.win[0].card_addr = 0;
 	entry->mem.win[0].host_addr = 0;
 	p += 2;
@@ -1101,9 +1101,9 @@ static int parse_cftable_entry(tuple_t *
 	break;
     case 0x40:
 	entry->mem.nwin = 1;
-	entry->mem.win[0].len = le16_to_cpu(*(u_short *)p) << 8;
+	entry->mem.win[0].len = le16_to_cpu(*(__le16 *)p) << 8;
 	entry->mem.win[0].card_addr =
-	    le16_to_cpu(*(u_short *)(p+2)) << 8;
+	    le16_to_cpu(*(__le16 *)(p+2)) << 8;
 	entry->mem.win[0].host_addr = 0;
 	p += 4;
 	if (p > q) return CS_BAD_TUPLE;
@@ -1140,7 +1140,7 @@ static int parse_bar(tuple_t *tuple, cis
     p = (u_char *)tuple->TupleData;
     bar->attr = *p;
     p += 2;
-    bar->size = le32_to_cpu(*(u_int *)p);
+    bar->size = le32_to_cpu(*(__le32 *)p);
     return CS_SUCCESS;
 }
 
@@ -1153,7 +1153,7 @@ static int parse_config_cb(tuple_t *tupl
 	return CS_BAD_TUPLE;
     config->last_idx = *(++p);
     p++;
-    config->base = le32_to_cpu(*(u_int *)p);
+    config->base = le32_to_cpu(*(__le32 *)p);
     config->subtuples = tuple->TupleDataLen - 6;
     return CS_SUCCESS;
 }
@@ -1269,7 +1269,7 @@ static int parse_vers_2(tuple_t *tuple, 
 
     v2->vers = p[0];
     v2->comply = p[1];
-    v2->dindex = le16_to_cpu(*(u_short *)(p+2));
+    v2->dindex = le16_to_cpu(*(__le16 *)(p+2));
     v2->vspec8 = p[6];
     v2->vspec9 = p[7];
     v2->nhdr = p[8];
@@ -1310,8 +1310,8 @@ static int parse_format(tuple_t *tuple, 
 
     fmt->type = p[0];
     fmt->edc = p[1];
-    fmt->offset = le32_to_cpu(*(u_int *)(p+2));
-    fmt->length = le32_to_cpu(*(u_int *)(p+6));
+    fmt->offset = le32_to_cpu(*(__le32 *)(p+2));
+    fmt->length = le32_to_cpu(*(__le32 *)(p+6));
 
     return CS_SUCCESS;
 }

