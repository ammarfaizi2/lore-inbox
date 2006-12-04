Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937076AbWLDQWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937076AbWLDQWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937083AbWLDQWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:22:40 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40461
	"EHLO emea1-mh.id2.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S937076AbWLDQWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:22:39 -0500
Message-Id: <4574598F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 04 Dec 2006 16:23:27 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fully support linker generated .eh_frame_hdr section
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that binutils' ld is able to properly populate .eh_frame_hdr in the
Linux kernel case, here's a patch to add some functionality to the Dwarf2
unwinder to actually be able to make use of this (applies on firstfloor
tree with the previously sent patch to add debug output, but not on plain
2.6.19).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: 2.6.19-ff-unwind-debug-msg/kernel/unwind.c
===================================================================
--- 2.6.19-ff-unwind-debug-msg.orig/kernel/unwind.c	2006-12-04 17:11:14.000000000 +0100
+++ 2.6.19-ff-unwind-debug-msg/kernel/unwind.c	2006-12-04 17:11:45.000000000 +0100
@@ -164,7 +164,9 @@ static struct unwind_table *find_table(u
 
 static unsigned long read_pointer(const u8 **pLoc,
                                   const void *end,
-                                  signed ptrType);
+                                  signed ptrType,
+                                  unsigned long text_base,
+                                  unsigned long data_base);
 
 static void init_unwind_table(struct unwind_table *table,
                               const char *name,
@@ -189,10 +191,13 @@ static void init_unwind_table(struct unw
 	/* See if the linker provided table looks valid. */
 	if (header_size <= 4
 	    || header_start[0] != 1
-	    || (void *)read_pointer(&ptr, end, header_start[1]) != table_start
-	    || header_start[2] == DW_EH_PE_omit
-	    || read_pointer(&ptr, end, header_start[2]) <= 0
-	    || header_start[3] == DW_EH_PE_omit)
+	    || (void *)read_pointer(&ptr, end, header_start[1], 0, 0)
+	       != table_start
+	    || !read_pointer(&ptr, end, header_start[2], 0, 0)
+	    || !read_pointer(&ptr, end, header_start[3], 0,
+	                     (unsigned long)header_start)
+	    || !read_pointer(&ptr, end, header_start[3], 0,
+	                     (unsigned long)header_start))
 		header_start = NULL;
 	table->hdrsz = header_size;
 	smp_wmb();
@@ -282,7 +287,7 @@ static void __init setup_unwind_table(st
 		ptr = (const u8 *)(fde + 2);
 		if (!read_pointer(&ptr,
 		                  (const u8 *)(fde + 1) + *fde,
-		                  ptrType))
+		                  ptrType, 0, 0))
 			return;
 		++n;
 	}
@@ -317,7 +322,7 @@ static void __init setup_unwind_table(st
 		ptr = (const u8 *)(fde + 2);
 		header->table[n].start = read_pointer(&ptr,
 		                                      (const u8 *)(fde + 1) + *fde,
-		                                      fde_pointer_type(cie));
+		                                      fde_pointer_type(cie), 0, 0);
 		header->table[n].fde = (unsigned long)fde;
 		++n;
 	}
@@ -500,7 +505,9 @@ static const u32 *cie_for_fde(const u32 
 
 static unsigned long read_pointer(const u8 **pLoc,
                                   const void *end,
-                                  signed ptrType)
+                                  signed ptrType,
+                                  unsigned long text_base,
+                                  unsigned long data_base)
 {
 	unsigned long value = 0;
 	union {
@@ -572,6 +579,22 @@ static unsigned long read_pointer(const 
 	case DW_EH_PE_pcrel:
 		value += (unsigned long)*pLoc;
 		break;
+	case DW_EH_PE_textrel:
+		if (likely(text_base)) {
+			value += text_base;
+			break;
+		}
+		dprintk(2, "Text-relative encoding %02X (%p,%p), but zero text base.",
+		        ptrType, *pLoc, end);
+		return 0;
+	case DW_EH_PE_datarel:
+		if (likely(data_base)) {
+			value += data_base;
+			break;
+		}
+		dprintk(2, "Data-relative encoding %02X (%p,%p), but zero data base.",
+		        ptrType, *pLoc, end);
+		return 0;
 	default:
 		dprintk(2, "Cannot adjust pointer type %02X (%p,%p).",
 		        ptrType, *pLoc, end);
@@ -625,7 +648,8 @@ static signed fde_pointer_type(const u32
 			case 'P': {
 					signed ptrType = *ptr++;
 
-					if (!read_pointer(&ptr, end, ptrType) || ptr > end)
+					if (!read_pointer(&ptr, end, ptrType, 0, 0)
+					    || ptr > end)
 						return -1;
 				}
 				break;
@@ -685,7 +709,8 @@ static int processCFI(const u8 *start,
 			case DW_CFA_nop:
 				break;
 			case DW_CFA_set_loc:
-				if ((state->loc = read_pointer(&ptr.p8, end, ptrType)) == 0)
+				state->loc = read_pointer(&ptr.p8, end, ptrType, 0, 0);
+				if (state->loc == 0)
 					result = 0;
 				break;
 			case DW_CFA_advance_loc1:
@@ -854,9 +879,9 @@ int unwind(struct unwind_frame_info *fra
 			ptr = hdr + 4;
 			end = hdr + table->hdrsz;
 			if (tableSize
-			    && read_pointer(&ptr, end, hdr[1])
+			    && read_pointer(&ptr, end, hdr[1], 0, 0)
 			       == (unsigned long)table->address
-			    && (i = read_pointer(&ptr, end, hdr[2])) > 0
+			    && (i = read_pointer(&ptr, end, hdr[2], 0, 0)) > 0
 			    && i == (end - ptr) / (2 * tableSize)
 			    && !((end - ptr) % (2 * tableSize))) {
 				do {
@@ -864,7 +889,8 @@ int unwind(struct unwind_frame_info *fra
 
 					startLoc = read_pointer(&cur,
 					                        cur + tableSize,
-					                        hdr[3]);
+					                        hdr[3], 0,
+					                        (unsigned long)hdr);
 					if (pc < startLoc)
 						i /= 2;
 					else {
@@ -875,11 +901,13 @@ int unwind(struct unwind_frame_info *fra
 				if (i == 1
 				    && (startLoc = read_pointer(&ptr,
 				                                ptr + tableSize,
-				                                hdr[3])) != 0
+				                                hdr[3], 0,
+				                                (unsigned long)hdr)) != 0
 				    && pc >= startLoc)
 					fde = (void *)read_pointer(&ptr,
 					                           ptr + tableSize,
-					                           hdr[3]);
+					                           hdr[3], 0,
+					                           (unsigned long)hdr);
 			}
 		}
 		if(hdr && !fde)
@@ -894,13 +922,13 @@ int unwind(struct unwind_frame_info *fra
 			   && (ptrType = fde_pointer_type(cie)) >= 0
 			   && read_pointer(&ptr,
 			                   (const u8 *)(fde + 1) + *fde,
-			                   ptrType) == startLoc) {
+			                   ptrType, 0, 0) == startLoc) {
 				if (!(ptrType & DW_EH_PE_indirect))
 					ptrType &= DW_EH_PE_FORM|DW_EH_PE_signed;
 				endLoc = startLoc
 				         + read_pointer(&ptr,
 				                        (const u8 *)(fde + 1) + *fde,
-				                        ptrType);
+				                        ptrType, 0, 0);
 				if(pc >= endLoc)
 					fde = NULL;
 			} else
@@ -926,7 +954,7 @@ int unwind(struct unwind_frame_info *fra
 				ptr = (const u8 *)(fde + 2);
 				startLoc = read_pointer(&ptr,
 				                        (const u8 *)(fde + 1) + *fde,
-				                        ptrType);
+				                        ptrType, 0, 0);
 				if (!startLoc)
 					continue;
 				if (!(ptrType & DW_EH_PE_indirect))
@@ -934,7 +962,7 @@ int unwind(struct unwind_frame_info *fra
 				endLoc = startLoc
 				         + read_pointer(&ptr,
 				                        (const u8 *)(fde + 1) + *fde,
-				                        ptrType);
+				                        ptrType, 0, 0);
 				if (pc >= startLoc && pc < endLoc)
 					break;
 			}


