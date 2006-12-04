Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937070AbWLDQTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937070AbWLDQTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937066AbWLDQTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:19:16 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40321
	"EHLO emea1-mh.id2.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S937070AbWLDQTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:19:14 -0500
Message-Id: <457458C3.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 04 Dec 2006 16:20:03 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more sanity checks in Dwarf2 unwinder
References: <456D7985.76E4.0078.0@novell.com>
 <200611291414.56268.ak@suse.de>
In-Reply-To: <200611291414.56268.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Would it be possible to add printks for the EIOs? We want to know 
>when dwarf2 is corrupted.

Here's a patch to do this and some more (applies on firstfloor tree, but
probably not on plain 2.6.19).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19-ff/kernel/unwind.c	2006-12-04 15:39:48.000000000 +0100
+++ 2.6.19-ff-unwind-debug-msg/kernel/unwind.c	2006-12-04 14:23:36.000000000 +0100
@@ -137,6 +137,17 @@ struct unwind_state {
 
 static const struct cfa badCFA = { ARRAY_SIZE(reg_info), 1 };
 
+static unsigned unwind_debug;
+static int __init unwind_debug_setup(char *s)
+{
+	unwind_debug = simple_strtoul(s, NULL, 0);
+	return 1;
+}
+__setup("unwind_debug=", unwind_debug_setup);
+#define dprintk(lvl, fmt, args...) \
+	((void)(lvl > unwind_debug \
+	 || printk(KERN_DEBUG "unwind: " fmt "\n", ##args)))
+
 static struct unwind_table *find_table(unsigned long pc)
 {
 	struct unwind_table *table;
@@ -281,6 +292,7 @@ static void __init setup_unwind_table(st
 
 	hdrSize = 4 + sizeof(unsigned long) + sizeof(unsigned int)
 	        + 2 * n * sizeof(unsigned long);
+	dprintk(2, "Binary lookup table size for %s: %lu bytes", table->name, hdrSize);
 	header = alloc(hdrSize);
 	if (!header)
 		return;
@@ -500,13 +512,17 @@ static unsigned long read_pointer(const 
 		const unsigned long *pul;
 	} ptr;
 
-	if (ptrType < 0 || ptrType == DW_EH_PE_omit)
+	if (ptrType < 0 || ptrType == DW_EH_PE_omit) {
+		dprintk(1, "Invalid pointer encoding %02X (%p,%p).", ptrType, *pLoc, end);
 		return 0;
+	}
 	ptr.p8 = *pLoc;
 	switch(ptrType & DW_EH_PE_FORM) {
 	case DW_EH_PE_data2:
-		if (end < (const void *)(ptr.p16u + 1))
+		if (end < (const void *)(ptr.p16u + 1)) {
+			dprintk(1, "Data16 overrun (%p,%p).", ptr.p8, end);
 			return 0;
+		}
 		if(ptrType & DW_EH_PE_signed)
 			value = get_unaligned(ptr.p16s++);
 		else
@@ -514,8 +530,10 @@ static unsigned long read_pointer(const 
 		break;
 	case DW_EH_PE_data4:
 #ifdef CONFIG_64BIT
-		if (end < (const void *)(ptr.p32u + 1))
+		if (end < (const void *)(ptr.p32u + 1)) {
+			dprintk(1, "Data32 overrun (%p,%p).", ptr.p8, end);
 			return 0;
+		}
 		if(ptrType & DW_EH_PE_signed)
 			value = get_unaligned(ptr.p32s++);
 		else
@@ -527,8 +545,10 @@ static unsigned long read_pointer(const 
 		BUILD_BUG_ON(sizeof(u32) != sizeof(value));
 #endif
 	case DW_EH_PE_native:
-		if (end < (const void *)(ptr.pul + 1))
+		if (end < (const void *)(ptr.pul + 1)) {
+			dprintk(1, "DataUL overrun (%p,%p).", ptr.p8, end);
 			return 0;
+		}
 		value = get_unaligned(ptr.pul++);
 		break;
 	case DW_EH_PE_leb128:
@@ -536,10 +556,14 @@ static unsigned long read_pointer(const 
 		value = ptrType & DW_EH_PE_signed
 		        ? get_sleb128(&ptr.p8, end)
 		        : get_uleb128(&ptr.p8, end);
-		if ((const void *)ptr.p8 > end)
+		if ((const void *)ptr.p8 > end) {
+			dprintk(1, "DataLEB overrun (%p,%p).", ptr.p8, end);
 			return 0;
+		}
 		break;
 	default:
+		dprintk(2, "Cannot decode pointer type %02X (%p,%p).",
+		        ptrType, ptr.p8, end);
 		return 0;
 	}
 	switch(ptrType & DW_EH_PE_ADJUST) {
@@ -549,11 +573,16 @@ static unsigned long read_pointer(const 
 		value += (unsigned long)*pLoc;
 		break;
 	default:
+		dprintk(2, "Cannot adjust pointer type %02X (%p,%p).",
+		        ptrType, *pLoc, end);
 		return 0;
 	}
 	if ((ptrType & DW_EH_PE_indirect)
-	    && probe_kernel_address((unsigned long *)value, value))
+	    && probe_kernel_address((unsigned long *)value, value)) {
+		dprintk(1, "Cannot read indirect value %lx (%p,%p).",
+		        value, *pLoc, end);
 		return 0;
+	}
 	*pLoc = ptr.p8;
 
 	return value;
@@ -702,8 +731,10 @@ static int processCFI(const u8 *start,
 					state->label = NULL;
 					return 1;
 				}
-				if (state->stackDepth >= MAX_STACK_DEPTH)
+				if (state->stackDepth >= MAX_STACK_DEPTH) {
+					dprintk(1, "State stack overflow (%p,%p).", ptr.p8, end);
 					return 0;
+				}
 				state->stack[state->stackDepth++] = ptr.p8;
 				break;
 			case DW_CFA_restore_state:
@@ -718,8 +749,10 @@ static int processCFI(const u8 *start,
 					result = processCFI(start, end, 0, ptrType, state);
 					state->loc = loc;
 					state->label = label;
-				} else
+				} else {
+					dprintk(1, "State stack underflow (%p,%p).", ptr.p8, end);
 					return 0;
+				}
 				break;
 			case DW_CFA_def_cfa:
 				state->cfa.reg = get_uleb128(&ptr.p8, end);
@@ -751,6 +784,7 @@ static int processCFI(const u8 *start,
 				break;
 			case DW_CFA_GNU_window_save:
 			default:
+				dprintk(1, "Unrecognized CFI op %02X (%p,%p).", ptr.p8[-1], ptr.p8 - 1, end);
 				result = 0;
 				break;
 			}
@@ -766,12 +800,17 @@ static int processCFI(const u8 *start,
 			set_rule(*ptr.p8++ & 0x3f, Nowhere, 0, state);
 			break;
 		}
-		if (ptr.p8 > end)
+		if (ptr.p8 > end) {
+			dprintk(1, "Data overrun (%p,%p).", ptr.p8, end);
 			result = 0;
+		}
 		if (result && targetLoc != 0 && targetLoc < state->loc)
 			return 1;
 	}
 
+	if (result && ptr.p8 < end)
+		dprintk(1, "Data underrun (%p,%p).", ptr.p8, end);
+
 	return result
 	   && ptr.p8 == end
 	   && (targetLoc == 0
@@ -843,6 +882,8 @@ int unwind(struct unwind_frame_info *fra
 					                           hdr[3]);
 			}
 		}
+		if(hdr && !fde)
+			dprintk(3, "Binary lookup for %lx failed.", pc);
 
 		if (fde != NULL) {
 			cie = cie_for_fde(fde, table);
@@ -864,6 +905,8 @@ int unwind(struct unwind_frame_info *fra
 					fde = NULL;
 			} else
 				fde = NULL;
+			if(!fde)
+				dprintk(1, "Binary lookup result for %lx discarded.", pc);
 		}
 		if (fde == NULL) {
 			for (fde = table->address, tableSize = table->size;
@@ -895,6 +938,8 @@ int unwind(struct unwind_frame_info *fra
 				if (pc >= startLoc && pc < endLoc)
 					break;
 			}
+			if(!fde)
+				dprintk(3, "Linear lookup for %lx failed.", pc);
 		}
 	}
 	if (cie != NULL) {
@@ -928,6 +973,8 @@ int unwind(struct unwind_frame_info *fra
 			if (ptr >= end || *ptr)
 				cie = NULL;
 		}
+		if(!cie)
+			dprintk(1, "CIE unusable (%p,%p).", ptr, end);
 		++ptr;
 	}
 	if (cie != NULL) {
@@ -938,9 +985,11 @@ int unwind(struct unwind_frame_info *fra
 		if (state.codeAlign == 0 || state.dataAlign == 0 || ptr >= end)
 			cie = NULL;
 		else if (UNW_PC(frame) % state.codeAlign
-		         || UNW_SP(frame) % sleb128abs(state.dataAlign))
+		         || UNW_SP(frame) % sleb128abs(state.dataAlign)) {
+			dprintk(1, "Input pointer(s) misaligned (%lx,%lx).",
+			        UNW_PC(frame), UNW_SP(frame));
 			return -EPERM;
-		else {
+		} else {
 			retAddrReg = state.version <= 1 ? *ptr++ : get_uleb128(&ptr, end);
 			/* skip augmentation */
 			if (((const char *)(cie + 2))[1] == 'z') {
@@ -954,6 +1003,8 @@ int unwind(struct unwind_frame_info *fra
 			   || reg_info[retAddrReg].width != sizeof(unsigned long))
 				cie = NULL;
 		}
+		if(!cie)
+			dprintk(1, "CIE validation failed (%p,%p).", ptr, end);
 	}
 	if (cie != NULL) {
 		state.cieStart = ptr;
@@ -967,6 +1018,8 @@ int unwind(struct unwind_frame_info *fra
 			if ((ptr += augSize) > end)
 				fde = NULL;
 		}
+		if(!fde)
+			dprintk(1, "FDE validation failed (%p,%p).", ptr, end);
 	}
 	if (cie == NULL || fde == NULL) {
 #ifdef CONFIG_FRAME_POINTER
@@ -1025,8 +1078,10 @@ int unwind(struct unwind_frame_info *fra
 	   || state.cfa.reg >= ARRAY_SIZE(reg_info)
 	   || reg_info[state.cfa.reg].width != sizeof(unsigned long)
 	   || FRAME_REG(state.cfa.reg, unsigned long) % sizeof(unsigned long)
-	   || state.cfa.offs % sizeof(unsigned long))
+	   || state.cfa.offs % sizeof(unsigned long)) {
+		dprintk(1, "Unusable unwind info (%p,%p).", ptr, end);
 		return -EIO;
+	}
 	/* update frame */
 #ifndef CONFIG_AS_CFI_SIGNAL_FRAME
 	if(frame->call_frame
@@ -1051,6 +1106,8 @@ int unwind(struct unwind_frame_info *fra
 		if (REG_INVALID(i)) {
 			if (state.regs[i].where == Nowhere)
 				continue;
+			dprintk(1, "Cannot restore register %u (%d).",
+			        i, state.regs[i].where);
 			return -EIO;
 		}
 		switch(state.regs[i].where) {
@@ -1059,8 +1116,11 @@ int unwind(struct unwind_frame_info *fra
 		case Register:
 			if (state.regs[i].value >= ARRAY_SIZE(reg_info)
 			   || REG_INVALID(state.regs[i].value)
-			   || reg_info[i].width > reg_info[state.regs[i].value].width)
+			   || reg_info[i].width > reg_info[state.regs[i].value].width) {
+				dprintk(1, "Cannot restore register %u from register %lu.",
+				        i, state.regs[i].value);
 				return -EIO;
+			}
 			switch(reg_info[state.regs[i].value].width) {
 #define CASE(n) \
 			case sizeof(u##n): \
@@ -1070,6 +1130,9 @@ int unwind(struct unwind_frame_info *fra
 			CASES;
 #undef CASE
 			default:
+				dprintk(1, "Unsupported register size %u (%lu).",
+				        reg_info[state.regs[i].value].width,
+				        state.regs[i].value);
 				return -EIO;
 			}
 			break;
@@ -1094,12 +1157,17 @@ int unwind(struct unwind_frame_info *fra
 			CASES;
 #undef CASE
 			default:
+				dprintk(1, "Unsupported register size %u (%u).",
+				        reg_info[i].width, i);
 				return -EIO;
 			}
 			break;
 		case Value:
-			if (reg_info[i].width != sizeof(unsigned long))
+			if (reg_info[i].width != sizeof(unsigned long)) {
+				dprintk(1, "Unsupported value size %u (%u).",
+				        reg_info[i].width, i);
 				return -EIO;
+			}
 			FRAME_REG(i, unsigned long) = cfa + state.regs[i].value
 			                                    * state.dataAlign;
 			break;
@@ -1111,8 +1179,11 @@ int unwind(struct unwind_frame_info *fra
 				    % sizeof(unsigned long)
 				    || addr < startLoc
 				    || addr + sizeof(unsigned long) < addr
-				    || addr + sizeof(unsigned long) > endLoc)
+				    || addr + sizeof(unsigned long) > endLoc) {
+					dprintk(1, "Bad memory location %lx (%lx).",
+					        addr, state.regs[i].value);
 					return -EIO;
+				}
 				switch(reg_info[i].width) {
 #define CASE(n)     case sizeof(u##n): \
 					probe_kernel_address((u##n *)addr, FRAME_REG(i, u##n)); \
@@ -1120,6 +1191,8 @@ int unwind(struct unwind_frame_info *fra
 				CASES;
 #undef CASE
 				default:
+					dprintk(1, "Unsupported memory size %u (%u).",
+					        reg_info[i].width, i);
 					return -EIO;
 				}
 			}
@@ -1128,9 +1201,15 @@ int unwind(struct unwind_frame_info *fra
 	}
 
 	if (UNW_PC(frame) % state.codeAlign
-	    || UNW_SP(frame) % sleb128abs(state.dataAlign)
-	    || (pc == UNW_PC(frame) && sp == UNW_SP(frame)))
+	    || UNW_SP(frame) % sleb128abs(state.dataAlign)) {
+		dprintk(1, "Output pointer(s) misaligned (%lx,%lx).",
+		        UNW_PC(frame), UNW_SP(frame));
 		return -EIO;
+	}
+	if (pc == UNW_PC(frame) && sp == UNW_SP(frame)) {
+		dprintk(1, "No progress (%lx,%lx).", pc, sp);
+		return -EIO;
+	}
 
 	return 0;
 #undef CASES


