Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130217AbQKBOKo>; Thu, 2 Nov 2000 09:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131684AbQKBOKf>; Thu, 2 Nov 2000 09:10:35 -0500
Received: from [62.172.234.2] ([62.172.234.2]:53133 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130217AbQKBOKO>;
	Thu, 2 Nov 2000 09:10:14 -0500
Date: Thu, 2 Nov 2000 14:10:49 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: kernel@kvack.org
cc: "Dr. David Gilbert" <dg@px.uk.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.3.96.1001102085215.13796A-100000@kanga.kvack.org>
Message-ID: <Pine.LNX.4.21.0011021408040.2508-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000 kernel@kvack.org wrote:

> On Thu, 2 Nov 2000, Dr. David Gilbert wrote:
> 
> > I've included /proc/pci, /proc/interrupt /proc/cpuinfo and the kernel
> > config (2.4.0-test10).
> 
> > CONFIG_MTRR=y
> 
> I bet it's the mtrr bugs.  Take a look in /proc/mtrr.  Someone suggested
> that if you disable the cachable settings in the BIOS for the BIOS/VGA/ROM
> regions, the bug can be avoided.
> 

yes, that someone was me :) It did indeed help to my 4way 6G RAM Xeon --
the performance improved 40x!. Also, using David's mtrr.patch helped with
the problem of eepro100 interfaces sometimes not coming up properly (and
generally, it is nice to see all your 6G appear in /proc/mtrr).

So, here is David's mtrr patch. Although in his case ("only" 4G) it
shouldn't be needed.... it is for 36bit MTRRs I assume.

Regards,
Tigran

diff -rua linux-2.4.0test9/arch/i386/kernel/mtrr.c linux-2.4.0test9.mod/arch/i386/kernel/mtrr.c
--- linux-2.4.0test9/arch/i386/kernel/mtrr.c	Wed Oct 11 19:54:56 2000
+++ linux-2.4.0test9.mod/arch/i386/kernel/mtrr.c	Wed Oct 11 20:48:26 2000
@@ -503,9 +503,9 @@
 static void intel_get_mtrr (unsigned int reg, unsigned long *base,
 			    unsigned long *size, mtrr_type *type)
 {
-    unsigned long dummy, mask_lo, base_lo;
+    unsigned long mask_lo, mask_hi, base_lo, base_hi;
 
-    rdmsr (MTRRphysMask_MSR(reg), mask_lo, dummy);
+    rdmsr (MTRRphysMask_MSR(reg), mask_lo, mask_hi);
     if ( (mask_lo & 0x800) == 0 )
     {
 	/*  Invalid (i.e. free) range  */
@@ -515,20 +515,17 @@
 	return;
     }
 
-    rdmsr(MTRRphysBase_MSR(reg), base_lo, dummy);
+    rdmsr(MTRRphysBase_MSR(reg), base_lo, base_hi);
 
-    /* We ignore the extra address bits (32-35). If someone wants to
-       run x86 Linux on a machine with >4GB memory, this will be the
-       least of their problems. */
+    /* Work out the shifted address mask. */
+    mask_lo = 0xff000000 | mask_hi << (32 - PAGE_SHIFT)
+		| mask_lo >> PAGE_SHIFT;
 
-    /* Clean up mask_lo so it gives the real address mask. */
-    mask_lo = (mask_lo & 0xfffff000UL);
     /* This works correctly if size is a power of two, i.e. a
        contiguous range. */
-    *size = ~(mask_lo - 1);
-
-    *base = (base_lo & 0xfffff000UL);
-    *type = (base_lo & 0xff);
+    *size = -mask_lo;
+    *base = base_hi << (32 - PAGE_SHIFT) | base_lo >> PAGE_SHIFT;
+    *type = base_lo & 0xff;
 }   /*  End Function intel_get_mtrr  */
 
 static void cyrix_get_arr (unsigned int reg, unsigned long *base,
@@ -553,13 +550,13 @@
     /* Enable interrupts if it was enabled previously */
     __restore_flags (flags);
     shift = ((unsigned char *) base)[1] & 0x0f;
-    *base &= 0xfffff000UL;
+    *base >>= PAGE_SHIFT;
 
     /* Power of two, at least 4K on ARR0-ARR6, 256K on ARR7
      * Note: shift==0xf means 4G, this is unsupported.
      */
     if (shift)
-      *size = (reg < 7 ? 0x800UL : 0x20000UL) << shift;
+      *size = (reg < 7 ? 0x1UL : 0x40UL) << (shift - 1);
     else
       *size = 0;
 
@@ -596,7 +593,7 @@
     /*  Upper dword is region 1, lower is region 0  */
     if (reg == 1) low = high;
     /*  The base masks off on the right alignment  */
-    *base = low & 0xFFFE0000;
+    *base = (low & 0xFFFE0000) >> PAGE_SHIFT;
     *type = 0;
     if (low & 1) *type = MTRR_TYPE_UNCACHABLE;
     if (low & 2) *type = MTRR_TYPE_WRCOMB;
@@ -621,7 +618,7 @@
      *	*128K	...
      */
     low = (~low) & 0x1FFFC;
-    *size = (low + 4) << 15;
+    *size = (low + 4) << (15 - PAGE_SHIFT);
     return;
 }   /*  End Function amd_get_mtrr  */
 
@@ -634,8 +631,8 @@
 static void centaur_get_mcr (unsigned int reg, unsigned long *base,
 			     unsigned long *size, mtrr_type *type)
 {
-    *base = centaur_mcr[reg].high & 0xfffff000;
-    *size = (~(centaur_mcr[reg].low & 0xfffff000))+1;
+    *base = centaur_mcr[reg].high >> PAGE_SHIFT;
+    *size = -(centaur_mcr[reg].low & 0xfffff000) >> PAGE_SHIFT;
     *type = MTRR_TYPE_WRCOMB;	/*  If it is there, it is write-combining  */
 }   /*  End Function centaur_get_mcr  */
 
@@ -665,8 +662,10 @@
     }
     else
     {
-	wrmsr (MTRRphysBase_MSR (reg), base | type, 0);
-	wrmsr (MTRRphysMask_MSR (reg), ~(size - 1) | 0x800, 0);
+	wrmsr (MTRRphysBase_MSR (reg), base << PAGE_SHIFT | type,
+	       (base & 0xf00000) >> (32 - PAGE_SHIFT));
+	wrmsr (MTRRphysMask_MSR (reg), -size << PAGE_SHIFT | 0x800,
+	       (-size & 0xf00000) >> (32 - PAGE_SHIFT));
     }
     if (do_safe) set_mtrr_done (&ctxt);
 }   /*  End Function intel_set_mtrr_up  */
@@ -680,7 +679,9 @@
     arr = CX86_ARR_BASE + (reg << 1) + reg; /* avoid multiplication by 3 */
 
     /* count down from 32M (ARR0-ARR6) or from 2G (ARR7) */
-    size >>= (reg < 7 ? 12 : 18);
+    if (reg >= 7)
+	size >>= 6;
+
     size &= 0x7fff; /* make sure arr_size <= 14 */
     for(arr_size = 0; size; arr_size++, size >>= 1);
 
@@ -705,6 +706,7 @@
     }
 
     if (do_safe) set_mtrr_prepare (&ctxt);
+    base <<= PAGE_SHIFT;
     setCx86(arr,    ((unsigned char *) &base)[3]);
     setCx86(arr+1,  ((unsigned char *) &base)[2]);
     setCx86(arr+2, (((unsigned char *) &base)[1]) | arr_size);
@@ -724,34 +726,36 @@
     [RETURNS] Nothing.
 */
 {
-    u32 low, high;
+    u32 regs[2];
     struct set_mtrr_context ctxt;
 
     if (do_safe) set_mtrr_prepare (&ctxt);
     /*
      *	Low is MTRR0 , High MTRR 1
      */
-    rdmsr (0xC0000085, low, high);
+    rdmsr (0xC0000085, regs[0], regs[1]);
     /*
      *	Blank to disable
      */
     if (size == 0)
-	*(reg ? &high : &low) = 0;
+	regs[reg] = 0;
     else
-	/* Set the register to the base (already shifted for us), the
-	   type (off by one) and an inverted bitmask of the size
-	   The size is the only odd bit. We are fed say 512K
-	   We invert this and we get 111 1111 1111 1011 but
-	   if you subtract one and invert you get the desired
-	   111 1111 1111 1100 mask
-	   */
-	*(reg ? &high : &low)=(((~(size-1))>>15)&0x0001FFFC)|base|(type+1);
+	/* Set the register to the base, the type (off by one) and an
+	   inverted bitmask of the size The size is the only odd
+	   bit. We are fed say 512K We invert this and we get 111 1111
+	   1111 1011 but if you subtract one and invert you get the
+	   desired 111 1111 1111 1100 mask
+
+	   But ~(x - 1) == ~x + 1 == -x. Two's complement rocks!  */
+	regs[reg] = (-size>>(15-PAGE_SHIFT) & 0x0001FFFC)
+	    			| (base<<PAGE_SHIFT) | (type+1);
+
     /*
      *	The writeback rule is quite specific. See the manual. Its
      *	disable local interrupts, write back the cache, set the mtrr
      */
     __asm__ __volatile__ ("wbinvd" : : : "memory");
-    wrmsr (0xC0000085, low, high);
+    wrmsr (0xC0000085, regs[0], regs[1]);
     if (do_safe) set_mtrr_done (&ctxt);
 }   /*  End Function amd_set_mtrr_up  */
 
@@ -771,9 +775,9 @@
     }
     else
     {
-        high = base & 0xfffff000; /* base works on 4K pages... */
-        low = ((~(size-1))&0xfffff000);
-        low |= 0x1f;		  /* only support write-combining... */
+	high = base << PAGE_SHIFT;
+	low = -size << PAGE_SHIFT | 0x1f; /* only support write-combining... */
+
     }
     centaur_mcr[reg].high = high;
     centaur_mcr[reg].low = low;
@@ -1078,7 +1082,7 @@
     for (i = 0; i < max; ++i)
     {
 	(*get_mtrr) (i, &lbase, &lsize, &ltype);
-	if (lsize < 1) return i;
+	if (lsize == 0) return i;
     }
     return -ENOSPC;
 }   /*  End Function generic_get_free_region  */
@@ -1095,7 +1099,7 @@
     unsigned long lbase, lsize;
 
     /* If we are to set up a region >32M then look at ARR7 immediately */
-    if (size > 0x2000000UL)
+    if (size > 0x2000)
     {
 	cyrix_get_arr (7, &lbase, &lsize, &ltype);
 	if (lsize < 1) return 7;
@@ -1107,11 +1111,11 @@
 	{
 	    cyrix_get_arr (i, &lbase, &lsize, &ltype);
 	    if ((i == 3) && arr3_protected) continue;
-	    if (lsize < 1) return i;
+	    if (lsize == 0) return i;
 	}
 	/* ARR0-ARR6 isn't free, try ARR7 but its size must be at least 256K */
 	cyrix_get_arr (i, &lbase, &lsize, &ltype);
-	if ((lsize < 1) && (size >= 0x40000)) return i;
+	if ((lsize == 0) && (size >= 0x40)) return i;
     }
     return -ENOSPC;
 }   /*  End Function cyrix_get_free_region  */
@@ -1205,7 +1209,7 @@
 	/*  Fall through  */
       case X86_VENDOR_CYRIX:
       case X86_VENDOR_CENTAUR:
-	if ( (base & 0xfff) || (size & 0xfff) )
+	if ( (base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1)) )
 	{
 	    printk ("mtrr: size and base must be multiples of 4 kiB\n");
 	    printk ("mtrr: size: %lx  base: %lx\n", size, base);
@@ -1246,6 +1250,12 @@
 	printk ("mtrr: type: %u illegal\n", type);
 	return -EINVAL;
     }
+
+    /* For all CPU types, the checks above should have ensured that
+       base and size are page aligned */
+    base >>= PAGE_SHIFT;
+    size >>= PAGE_SHIFT;
+
     /*  If the type is WC, check that this processor supports it  */
     if ( (type == MTRR_TYPE_WRCOMB) && !have_wrcomb () )
     {
@@ -1265,7 +1275,8 @@
 	if ( (base < lbase) || (base + size > lbase + lsize) )
 	{
 	    up(&main_lock);
-	    printk (KERN_WARNING "mtrr: 0x%lx,0x%lx overlaps existing 0x%lx,0x%lx\n",
+ 	    printk (KERN_WARNING "mtrr: 0x%lx000,0x%lx000 overlaps existing"
+ 		    " 0x%lx000,0x%lx000\n",
 		    base, size, lbase, lsize);
 	    return -EINVAL;
 	}
@@ -1274,7 +1285,7 @@
 	{
 	    if (type == MTRR_TYPE_UNCACHABLE) continue;
 	    up(&main_lock);
-	    printk ( "mtrr: type mismatch for %lx,%lx old: %s new: %s\n",
+ 	    printk ( "mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
 		     base, size, attrib_to_str (ltype), attrib_to_str (type) );
 	    return -EINVAL;
 	}
@@ -1329,6 +1340,7 @@
     unsigned long lbase, lsize;
 
     if ( !(boot_cpu_data.x86_capability & X86_FEATURE_MTRR) ) return -ENODEV;
+
     max = get_num_var_ranges ();
     down (&main_lock);
     if (reg < 0)
@@ -1337,7 +1349,8 @@
 	for (i = 0; i < max; ++i)
 	{
 	    (*get_mtrr) (i, &lbase, &lsize, &ltype);
-	    if ( (lbase == base) && (lsize == size) )
+	    if (lbase < 0x100000 && lbase << PAGE_SHIFT == base
+		&& lsize < 0x100000 && lsize << PAGE_SHIFT == size)
 	    {
 		reg = i;
 		break;
@@ -1346,7 +1359,7 @@
 	if (reg < 0)
 	{
 	    up(&main_lock);
-	    printk ("mtrr: no MTRR for %lx,%lx found\n", base, size);
+ 	    printk ("mtrr: no MTRR for %lx000,%lx000 found\n", base, size);
 	    return -EINVAL;
 	}
     }
@@ -1536,7 +1549,16 @@
 	    return -EFAULT;
 	if ( gentry.regnum >= get_num_var_ranges () ) return -EINVAL;
 	(*get_mtrr) (gentry.regnum, &gentry.base, &gentry.size, &type);
-	gentry.type = type;
+
+	/* Hide entries that go above 4GB */
+	if (gentry.base + gentry.size > 0x100000 || gentry.size == 0x100000)
+	    gentry.base = gentry.size = gentry.type = 0;
+	else {
+	    gentry.base <<= PAGE_SHIFT;
+	    gentry.size <<= PAGE_SHIFT;
+	    gentry.type = type;
+	}
+	
 	if ( copy_to_user ( (void *) arg, &gentry, sizeof gentry) )
 	     return -EFAULT;
 	break;
@@ -1595,24 +1617,24 @@
     for (i = 0; i < max; i++)
     {
 	(*get_mtrr) (i, &base, &size, &type);
-	if (size < 1) usage_table[i] = 0;
+	if (size == 0) usage_table[i] = 0;
 	else
 	{
-	    if (size < 0x100000)
+	    if (size < 0x100000 >> PAGE_SHIFT)
 	    {
-		/* 1MB */
-		factor = 'k';
-		size >>= 10;
+		/* less than 1MB */
+		factor = 'K';
+		size <<= PAGE_SHIFT - 10;
 	    }
 	    else
 	    {
 		factor = 'M';
-		size >>= 20;
+		size >>= 20 - PAGE_SHIFT;
 	    }
 	    sprintf
 		(ascii_buffer + ascii_buf_bytes,
-		 "reg%02i: base=0x%08lx (%4liMB), size=%4li%cB: %s, count=%d\n",
-		 i, base, base>>20, size, factor,
+		 "reg%02i: base=0x%05lx000 (%4liMB), size=%4li%cB: %s, count=%d\n",
+		 i, base, base >> (20 - PAGE_SHIFT), size, factor,
 		 attrib_to_str (type), usage_table[i]);
 	    ascii_buf_bytes += strlen (ascii_buffer + ascii_buf_bytes);
 	}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
