Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTLLQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLLQ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:59:19 -0500
Received: from bolt.sonic.net ([208.201.242.18]:49891 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S261500AbTLLQ7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:59:07 -0500
Date: Fri, 12 Dec 2003 08:59:02 -0800
From: David Hinds <dhinds@sonic.net>
To: Roger Larsson <roger.larsson@norran.net>
Cc: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: UPD: "do_IRQ: near stack overflow" when inserting CF disk
Message-ID: <20031212085902.A7458@sonic.net>
References: <200312121652.23036.roger.larsson@norran.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312121652.23036.roger.larsson@norran.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:52:22PM +0100, Roger Larsson wrote:
> 
> Summary:
>   Some routines allocate to much stack: validate_cis?
> 	several subtypes in the union cisparse_t are quite
> 	big (>250 bytes)
>   This eats stack (to much?) or only close enough to
>   trigger 'stackdefer' which might stress the drivers SMPness?

Marcelo,

Please apply this patch.  It reduces kernel stack usage for the PCMCIA
CIS processing code.

-- Dave


--- clean/linux-2.4.23/drivers/pcmcia/cistpl.c	Fri Jun 13 07:51:35 2003
+++ linux-2.4.23/drivers/pcmcia/cistpl.c	Fri Dec 12 08:50:52 2003
@@ -351,9 +351,12 @@
 
 int verify_cis_cache(socket_info_t *s)
 {
-    char buf[256], *caddr;
+    char *buf, *caddr;
     int i;
-    
+
+    buf = kmalloc(256, GFP_KERNEL);
+    if (buf == NULL)
+	return -1;
     caddr = s->cis_cache;
     for (i = 0; i < s->cis_used; i++) {
 #ifdef CONFIG_CARDBUS
@@ -368,6 +371,7 @@
 	    break;
 	caddr += s->cis_table[i].len;
     }
+    kfree(buf);
     return (i < s->cis_used);
 }
 
@@ -1410,20 +1414,31 @@
 
 int read_tuple(client_handle_t handle, cisdata_t code, void *parse)
 {
-    tuple_t tuple;
-    cisdata_t buf[255];
+    tuple_t *tuple;
+    cisdata_t *buf;
     int ret;
-    
-    tuple.DesiredTuple = code;
-    tuple.Attributes = TUPLE_RETURN_COMMON;
-    ret = pcmcia_get_first_tuple(handle, &tuple);
-    if (ret != CS_SUCCESS) return ret;
-    tuple.TupleData = buf;
-    tuple.TupleOffset = 0;
-    tuple.TupleDataMax = sizeof(buf);
-    ret = pcmcia_get_tuple_data(handle, &tuple);
-    if (ret != CS_SUCCESS) return ret;
-    ret = pcmcia_parse_tuple(handle, &tuple, parse);
+
+    buf = kmalloc(256, GFP_KERNEL);
+    if (buf == NULL)
+	return CS_OUT_OF_RESOURCE;
+    tuple = kmalloc(sizeof(*tuple), GFP_KERNEL);
+    if (tuple == NULL) {
+	kfree(buf);
+	return CS_OUT_OF_RESOURCE;
+    }
+    tuple->DesiredTuple = code;
+    tuple->Attributes = TUPLE_RETURN_COMMON;
+    ret = pcmcia_get_first_tuple(handle, tuple);
+    if (ret != CS_SUCCESS) goto done;
+    tuple->TupleData = buf;
+    tuple->TupleOffset = 0;
+    tuple->TupleDataMax = 255;
+    ret = pcmcia_get_tuple_data(handle, tuple);
+    if (ret != CS_SUCCESS) goto done;
+    ret = pcmcia_parse_tuple(handle, tuple, parse);
+done:
+    kfree(tuple);
+    kfree(buf);
     return ret;
 }
 
@@ -1439,50 +1454,61 @@
 
 int pcmcia_validate_cis(client_handle_t handle, cisinfo_t *info)
 {
-    tuple_t tuple;
-    cisparse_t p;
+    tuple_t *tuple;
+    cisparse_t *p;
     int ret, reserved, dev_ok = 0, ident_ok = 0;
 
     if (CHECK_HANDLE(handle))
 	return CS_BAD_HANDLE;
+    tuple = kmalloc(sizeof(*tuple), GFP_KERNEL);
+    if (tuple == NULL)
+	return CS_OUT_OF_RESOURCE;
+    p = kmalloc(sizeof(*p), GFP_KERNEL);
+    if (p == NULL) {
+	kfree(tuple);
+	return CS_OUT_OF_RESOURCE;
+    }
 
     info->Chains = reserved = 0;
-    tuple.DesiredTuple = RETURN_FIRST_TUPLE;
-    tuple.Attributes = TUPLE_RETURN_COMMON;
-    ret = pcmcia_get_first_tuple(handle, &tuple);
+    tuple->DesiredTuple = RETURN_FIRST_TUPLE;
+    tuple->Attributes = TUPLE_RETURN_COMMON;
+    ret = pcmcia_get_first_tuple(handle, tuple);
     if (ret != CS_SUCCESS)
-	return CS_SUCCESS;
+	goto done;
 
     /* First tuple should be DEVICE; we should really have either that
        or a CFTABLE_ENTRY of some sort */
-    if ((tuple.TupleCode == CISTPL_DEVICE) ||
-	(read_tuple(handle, CISTPL_CFTABLE_ENTRY, &p) == CS_SUCCESS) ||
-	(read_tuple(handle, CISTPL_CFTABLE_ENTRY_CB, &p) == CS_SUCCESS))
+    if ((tuple->TupleCode == CISTPL_DEVICE) ||
+	(read_tuple(handle, CISTPL_CFTABLE_ENTRY, p) == CS_SUCCESS) ||
+	(read_tuple(handle, CISTPL_CFTABLE_ENTRY_CB, p) == CS_SUCCESS))
 	dev_ok++;
 
     /* All cards should have a MANFID tuple, and/or a VERS_1 or VERS_2
        tuple, for card identification.  Certain old D-Link and Linksys
        cards have only a broken VERS_2 tuple; hence the bogus test. */
-    if ((read_tuple(handle, CISTPL_MANFID, &p) == CS_SUCCESS) ||
-	(read_tuple(handle, CISTPL_VERS_1, &p) == CS_SUCCESS) ||
-	(read_tuple(handle, CISTPL_VERS_2, &p) != CS_NO_MORE_ITEMS))
+    if ((read_tuple(handle, CISTPL_MANFID, p) == CS_SUCCESS) ||
+	(read_tuple(handle, CISTPL_VERS_1, p) == CS_SUCCESS) ||
+	(read_tuple(handle, CISTPL_VERS_2, p) != CS_NO_MORE_ITEMS))
 	ident_ok++;
 
     if (!dev_ok && !ident_ok)
-	return CS_SUCCESS;
+	goto done;
 
     for (info->Chains = 1; info->Chains < MAX_TUPLES; info->Chains++) {
-	ret = pcmcia_get_next_tuple(handle, &tuple);
+	ret = pcmcia_get_next_tuple(handle, tuple);
 	if (ret != CS_SUCCESS) break;
-	if (((tuple.TupleCode > 0x23) && (tuple.TupleCode < 0x40)) ||
-	    ((tuple.TupleCode > 0x47) && (tuple.TupleCode < 0x80)) ||
-	    ((tuple.TupleCode > 0x90) && (tuple.TupleCode < 0xff)))
+	if (((tuple->TupleCode > 0x23) && (tuple->TupleCode < 0x40)) ||
+	    ((tuple->TupleCode > 0x47) && (tuple->TupleCode < 0x80)) ||
+	    ((tuple->TupleCode > 0x90) && (tuple->TupleCode < 0xff)))
 	    reserved++;
     }
     if ((info->Chains == MAX_TUPLES) || (reserved > 5) ||
 	((!dev_ok || !ident_ok) && (info->Chains > 10)))
 	info->Chains = 0;
 
+done:
+    kfree(tuple);
+    kfree(p);
     return CS_SUCCESS;
 }
 
