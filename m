Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132245AbRCWANl>; Thu, 22 Mar 2001 19:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132272AbRCWAMq>; Thu, 22 Mar 2001 19:12:46 -0500
Received: from jalon.able.es ([212.97.163.2]:53148 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132278AbRCWAM3>;
	Thu, 22 Mar 2001 19:12:29 -0500
Date: Fri, 23 Mar 2001 01:11:41 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] gcc-3.0 warnings
Message-ID: <20010323011140.A1176@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, kernel list readers.

I have been building (and hopefully booting) ac-21 with gcc-3.0 snapshot
dated 20010312. I have cleared the 99% of the warnings that 3.0 issues
when building the kernel. Obviuosly, only in the main kernel part for
i386 and the drivers I use. I suppose other arch will require a similar
cleanup.

All are related to multiline strings in asm() sentences, that seem to have
been deprecated, and out: or default: labels at the end of blocks. Pathc
is inlined.

There are a couple more curious errors:
1) Is this a bug ?
make[1]: Entering directory `/usr/src/linux-2.4.2-ac21/arch/i386/kernel'
gcc ... -c -o setup.o setup.c
setup.c: In function `get_cpuinfo':
setup.c:2378: warning: unused variable `x86_udelay_tsc'
I have not patched this. Is a reminder of previous work, or should be used
for something and the use has flown erroneously ?

2)
gcc ... -c -o aic7xxx.o aic7xxx.c
aic7xxx.c: In function `ahc_print_scb':
aic7xxx.c:1335: warning: operation on `i' may be undefined
(nine times)
The piece of code is three reps of this:
printf("             %#02x %#02x %#02x %#02x\n",
    hscb->shared_data.cdb[i++],
    hscb->shared_data.cdb[i++],
    hscb->shared_data.cdb[i++],
    hscb->shared_data.cdb[i++]);
I suppose that gcc claims that the result is dependent on evaluation order
of the args to the printf(), so it is potentially dangerous. Just chaged it
to
    hscb->shared_data.cdb[ 1],
    hscb->shared_data.cdb[ 2],
    hscb->shared_data.cdb[ 3],
etc.

If mantainers do not like the way I corrected this, at least it is a list
of thigs to look at.

BTW, after that changes, the kernel built and booted ok.

============ patch-gcc-3

--- linux-2.4.2-ac21/fs/smbfs/cache.c.orig	Fri Mar 23 00:45:27 2001
+++ linux-2.4.2-ac21/fs/smbfs/cache.c	Fri Mar 23 00:46:04 2001
@@ -34,7 +34,7 @@
 
 	page = grab_cache_page(&dir->i_data, 0);
 	if (!page)
-		goto out;
+		return;
 
 	if (!Page_Uptodate(page))
 		goto out_unlock;
@@ -47,7 +47,6 @@
 out_unlock:
 	UnlockPage(page);
 	page_cache_release(page);
-out:
 }
 
 /*
--- linux-2.4.2-ac21/fs/smbfs/ioctl.c.orig	Fri Mar 23 00:46:22 2001
+++ linux-2.4.2-ac21/fs/smbfs/ioctl.c	Fri Mar 23 00:46:56 2001
@@ -45,7 +45,7 @@
 		if (!copy_from_user(&opt, (void *)arg, sizeof(opt)))
 			result = smb_newconn(server, &opt);
 		break;
-	default:
+	default:;
 	}
 
 	return result;
--- linux-2.4.2-ac21/include/asm-i386/string.h.orig	Thu Mar 22 23:17:03
2001
+++ linux-2.4.2-ac21/include/asm-i386/string.h	Thu Mar 22 23:20:40 2001
@@ -516,12 +516,12 @@
 {
 	if (!size)
 		return addr;
-	__asm__("repnz; scasb
-		jnz 1f
-		dec %%edi
-1:		"
-		: "=D" (addr), "=c" (size)
-		: "0" (addr), "1" (size), "a" (c));
+	__asm__("repnz; scasb\n\t"
+			"		jnz 1f\n\t"
+			"		dec %%edi\n\t"
+			"1:"
+			: "=D" (addr), "=c" (size)
+			: "0" (addr), "1" (size), "a" (c));
 	return addr;
 }
 
--- linux-2.4.2-ac21/include/asm-i386/system.h.orig	Thu Mar 22 23:20:50
2001
+++ linux-2.4.2-ac21/include/asm-i386/system.h	Thu Mar 22 23:21:47 2001
@@ -145,10 +145,10 @@
 		unsigned int low, unsigned int high)
 {
 __asm__ __volatile__ (
-	"1:	movl (%0), %%eax;
-		movl 4(%0), %%edx;
-		cmpxchg8b (%0);
-		jnz 1b"
+	"1:	movl (%0), %%eax;\n\t"
+	"movl 4(%0), %%edx;\n\t"
+	"cmpxchg8b (%0);\n\t"
+	"jnz 1b"
 	::		"D"(ptr),
 			"b"(low),
 			"c"(high)
--- linux-2.4.2-ac21/include/asm-i386/checksum.h.orig	Thu Mar 22 23:21:58
2001
+++ linux-2.4.2-ac21/include/asm-i386/checksum.h	Thu Mar 22 23:25:19 2001
@@ -69,25 +69,24 @@
 					  unsigned int ihl) {
 	unsigned int sum;
 
-	__asm__ __volatile__("
-	    movl (%1), %0
-	    subl $4, %2
-	    jbe 2f
-	    addl 4(%1), %0
-	    adcl 8(%1), %0
-	    adcl 12(%1), %0
-1:	    adcl 16(%1), %0
-	    lea 4(%1), %1
-	    decl %2
-	    jne	1b
-	    adcl $0, %0
-	    movl %0, %2
-	    shrl $16, %0
-	    addw %w2, %w0
-	    adcl $0, %0
-	    notl %0
-2:
-	    "
+	__asm__ __volatile__(
+"	    movl (%1), %0\n"
+"	    subl $4, %2\n"
+"	    jbe 2f\n"
+"	    addl 4(%1), %0\n"
+"	    adcl 8(%1), %0\n"
+"	    adcl 12(%1), %0\n"
+"1:	    adcl 16(%1), %0\n"
+"	    lea 4(%1), %1\n"
+"	    decl %2\n"
+"	    jne	1b\n"
+"	    adcl $0, %0\n"
+"	    movl %0, %2\n"
+"	    shrl $16, %0\n"
+"	    addw %w2, %w0\n"
+"	    adcl $0, %0\n"
+"	    notl %0\n"
+"2:"
 	/* Since the input registers which are loaded with iph and ipl
 	   are modified, we must also specify them as outputs, or gcc
 	   will assume they contain their original values. */
@@ -102,10 +101,9 @@
 
 static inline unsigned int csum_fold(unsigned int sum)
 {
-	__asm__("
-		addl %1, %0
-		adcl $0xffff, %0
-		"
+	__asm__(
+		"addl %1, %0\n"
+		"adcl $0xffff, %0\n"
 		: "=r" (sum)
 		: "r" (sum << 16), "0" (sum & 0xffff0000)
 	);
@@ -118,12 +116,11 @@
 						   unsigned short proto,
 						   unsigned int sum) 
 {
-    __asm__("
-	addl %1, %0
-	adcl %2, %0
-	adcl %3, %0
-	adcl $0, %0
-	"
+    __asm__(
+	"addl %1, %0\n"
+	"adcl %2, %0\n"
+	"adcl %3, %0\n"
+	"adcl $0, %0\n"
 	: "=r" (sum)
 	: "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
     return sum;
@@ -158,19 +155,18 @@
 						     unsigned short proto,
 						     unsigned int sum) 
 {
-	__asm__("
-		addl 0(%1), %0
-		adcl 4(%1), %0
-		adcl 8(%1), %0
-		adcl 12(%1), %0
-		adcl 0(%2), %0
-		adcl 4(%2), %0
-		adcl 8(%2), %0
-		adcl 12(%2), %0
-		adcl %3, %0
-		adcl %4, %0
-		adcl $0, %0
-		"
+	__asm__(
+		"addl 0(%1), %0\n"
+		"adcl 4(%1), %0\n"
+		"adcl 8(%1), %0\n"
+		"adcl 12(%1), %0\n"
+		"adcl 0(%2), %0\n"
+		"adcl 4(%2), %0\n"
+		"adcl 8(%2), %0\n"
+		"adcl 12(%2), %0\n"
+		"adcl %3, %0\n"
+		"adcl %4, %0\n"
+		"adcl $0, %0\n"
 		: "=&r" (sum)
 		: "r" (saddr), "r" (daddr), 
 		  "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
--- linux-2.4.2-ac21/include/asm-i386/floppy.h.orig	Thu Mar 22 23:27:27
2001
+++ linux-2.4.2-ac21/include/asm-i386/floppy.h	Thu Mar 22 23:28:37 2001
@@ -75,28 +75,28 @@
 
 #ifndef NO_FLOPPY_ASSEMBLER
 	__asm__ (
-       "testl %1,%1
-	je 3f
-1:	inb %w4,%b0
-	andb $160,%b0
-	cmpb $160,%b0
-	jne 2f
-	incw %w4
-	testl %3,%3
-	jne 4f
-	inb %w4,%b0
-	movb %0,(%2)
-	jmp 5f
-4:     	movb (%2),%0
-	outb %b0,%w4
-5:	decw %w4
-	outb %0,$0x80
-	decl %1
-	incl %2
-	testl %1,%1
-	jne 1b
-3:	inb %w4,%b0
-2:	"
+"	testl %1,%1\n"
+"	je 3f\n"
+"1:	inb %w4,%b0\n"
+"	andb $160,%b0\n"
+"	cmpb $160,%b0\n"
+"	jne 2f\n"
+"	incw %w4\n"
+"	testl %3,%3\n"
+"	jne 4f\n"
+"	inb %w4,%b0\n"
+"	movb %0,(%2)\n"
+"	jmp 5f\n"
+"4:     	movb (%2),%0\n"
+"	outb %b0,%w4\n"
+"5:	decw %w4\n"
+"	outb %0,$0x80\n"
+"	decl %1\n"
+"	incl %2\n"
+"	testl %1,%1\n"
+"	jne 1b\n"
+"3:	inb %w4,%b0\n"
+"2:"
        : "=a" ((char) st), 
        "=c" ((long) virtual_dma_count), 
        "=S" ((long) virtual_dma_addr)
--- linux-2.4.2-ac21/net/ipv4/icmp.c.orig	Thu Mar 22 23:39:22 2001
+++ linux-2.4.2-ac21/net/ipv4/icmp.c	Thu Mar 22 23:42:23 2001
@@ -574,7 +574,7 @@
 				} else {
 					info = ip_rt_frag_needed(iph, ntohs(icmph->un.frag.mtu));
 					if (!info) 
-						goto out;
+						return;
 				}
 				break;
 			case ICMP_SR_FAILED:
@@ -585,7 +585,7 @@
 				break;
 		}
 		if (icmph->code>NR_ICMP_UNREACH)
-			goto out;
+			return;
 	} else if (icmph->type == ICMP_PARAMETERPROB) {
 		info = ntohl(icmph->un.gateway)>>24;
 	}
@@ -613,7 +613,7 @@
 			if (net_ratelimit())
 				printk(KERN_WARNING "%u.%u.%u.%u sent an
invalid ICMP error to a broadcast.\n",
 			       	NIPQUAD(skb->nh.iph->saddr));
-			goto out;
+			return;
 		}
 	}
 
@@ -621,7 +621,7 @@
 	 * avoid additional coding at protocol handlers.
 	 */
 	if (!pskb_may_pull(skb, iph->ihl*4+8))
-		goto out;
+		return;
 
 	iph = (struct iphdr *) skb->data;
 	protocol = iph->protocol;
@@ -668,7 +668,6 @@
 
 		ipprot = nextip;
   	}
-out:
 }
 
 
@@ -879,7 +878,7 @@
 	case CHECKSUM_NONE:
 		if ((u16)csum_fold(skb_checksum(skb, 0, skb->len, 0)))
 			goto error;
-	default:
+	default:;
 	}
 
 	if (!pskb_pull(skb, sizeof(struct icmphdr)))
--- linux-2.4.2-ac21/drivers/scsi/aic7xxx/aic7xxx.c.orig	Fri Mar 23
01:01:40 2001
+++ linux-2.4.2-ac21/drivers/scsi/aic7xxx/aic7xxx.c	Fri Mar 23 00:53:11
2001
@@ -1327,22 +1327,21 @@
 	       hscb->scsiid,
 	       hscb->lun,
 	       hscb->cdb_len);
-	i=0;
 	printf("Shared Data: %#02x %#02x %#02x %#02x\n",
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++]);
+	       hscb->shared_data.cdb[ 0],
+	       hscb->shared_data.cdb[ 1],
+	       hscb->shared_data.cdb[ 2],
+	       hscb->shared_data.cdb[ 3]);
 	printf("             %#02x %#02x %#02x %#02x\n",
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++]);
+	       hscb->shared_data.cdb[ 4],
+	       hscb->shared_data.cdb[ 5],
+	       hscb->shared_data.cdb[ 6],
+	       hscb->shared_data.cdb[ 7]);
 	printf("             %#02x %#02x %#02x %#02x\n",
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++],
-	       hscb->shared_data.cdb[i++]);
+	       hscb->shared_data.cdb[ 8],
+	       hscb->shared_data.cdb[ 9],
+	       hscb->shared_data.cdb[10],
+	       hscb->shared_data.cdb[11]);
 	printf("        dataptr:%#x datacnt:%#x sgptr:%#x tag:%#x\n",
 		ahc_le32toh(hscb->dataptr),
 		ahc_le32toh(hscb->datacnt),
--- linux-2.4.2-ac21/drivers/i2c/i2c-core.c.orig	Fri Mar 23 00:42:08 2001
+++ linux-2.4.2-ac21/drivers/i2c/i2c-core.c	Fri Mar 23 00:43:40 2001
@@ -378,13 +378,9 @@
 					if ((res = driver->
 							detach_client(client)))
 					{
-						printk("i2c-core.o: while "
-						       "unregistering driver "
-						       "`%s', the client at "
-						       "address %02x of
-						       adapter `%s' could not
-						       be detached; driver
-						       not unloaded!",
+						printk("i2c-core.o: while unregistering
driver <%s>"
+						   " the client at address %02x of
adapter <%s>"
+						   " could not be detached; driver
not unloaded!",
 						       driver->name,
 						       client->addr,
 						       adap->name);
--- linux-2.4.2-ac21/arch/i386/kernel/semaphore.c.orig	Thu Mar 22
23:42:54 2001
+++ linux-2.4.2-ac21/arch/i386/kernel/semaphore.c	Thu Mar 22 23:46:58
2001
@@ -231,49 +231,45 @@
 );
 
 asm(
-"
-.align 4
-.globl __down_read_failed
-__down_read_failed:
-	pushl	%edx
-	pushl	%ecx
-	jnc	2f
-
-3:	call	down_read_failed_biased
-
-1:	popl	%ecx
-	popl	%edx
-	ret
-
-2:	call	down_read_failed
-	" LOCK "subl	$1,(%eax)
-	jns	1b
-	jnc	2b
-	jmp	3b
-"
+".align 4\n"
+".globl __down_read_failed\n"
+"__down_read_failed:\n"
+"	pushl	%edx\n"
+"	pushl	%ecx\n"
+"	jnc	2f\n"
+"\n"
+"3:	call	down_read_failed_biased\n"
+"\n"
+"1:	popl	%ecx\n"
+"	popl	%edx\n"
+"	ret\n"
+"\n"
+"2:	call	down_read_failed\n"
+LOCK "subl	$1,(%eax)\n"
+"	jns	1b\n"
+"	jnc	2b\n"
+"	jmp	3b\n"
 );
 
 asm(
-"
-.align 4
-.globl __down_write_failed
-__down_write_failed:
-	pushl	%edx
-	pushl	%ecx
-	jnc	2f
-
-3:	call	down_write_failed_biased
-
-1:	popl	%ecx
-	popl	%edx
-	ret
-
-2:	call	down_write_failed
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jz	1b
-	jnc	2b
-	jmp	3b
-"
+".align 4\n"
+".globl __down_write_failed\n"
+"__down_write_failed:\n"
+"	pushl	%edx\n"
+"	pushl	%ecx\n"
+"	jnc	2f\n"
+"\n"
+"3:	call	down_write_failed_biased\n"
+"\n"
+"1:	popl	%ecx\n"
+"	popl	%edx\n"
+"	ret\n"
+"\n"
+"2:	call	down_write_failed\n"
+LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+"	jz	1b\n"
+"	jnc	2b\n"
+"	jmp	3b\n"
 );
 
 struct rw_semaphore *FASTCALL(rwsem_wake_readers(struct rw_semaphore *sem));
@@ -384,23 +380,21 @@
 }
 
 asm(
-"
-.align 4
-.globl __rwsem_wake
-__rwsem_wake:
-	pushl	%edx
-	pushl	%ecx
-
-	jz	1f
-	call	rwsem_wake_readers
-	jmp	2f
-
-1:	call	rwsem_wake_writer
-
-2:	popl	%ecx
-	popl	%edx
-	ret
-"
+".align 4\n"
+".globl __rwsem_wake\n"
+"__rwsem_wake:\n"
+"	pushl	%edx\n"
+"	pushl	%ecx\n"
+"\n"
+"	jz	1f\n"
+"	call	rwsem_wake_readers\n"
+"	jmp	2f\n"
+"\n"
+"1:	call	rwsem_wake_writer\n"
+"\n"
+"2:	popl	%ecx\n"
+"	popl	%edx\n"
+"	ret\n"
 );
 
 /* Called when someone has done an up that transitioned from
@@ -425,30 +419,28 @@
 
 #if defined(CONFIG_SMP)
 asm(
-"
-.align	4
-.globl	__write_lock_failed
-__write_lock_failed:
-	" LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)
-1:	cmpl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jne	1b
-
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jnz	__write_lock_failed
-	ret
-
-
-.align	4
-.globl	__read_lock_failed
-__read_lock_failed:
-	lock ; incl	(%eax)
-1:	cmpl	$1,(%eax)
-	js	1b
-
-	lock ; decl	(%eax)
-	js	__read_lock_failed
-	ret
-"
+".align	4\n"
+".globl	__write_lock_failed\n"
+"__write_lock_failed:\n"
+LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+"1:	cmpl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+"	jne	1b\n"
+"\n"
+LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+"	jnz	__write_lock_failed\n"
+"	ret\n"
+"\n"
+"\n"
+".align	4\n"
+".globl	__read_lock_failed\n"
+"__read_lock_failed:\n"
+"	lock ; incl	(%eax)\n"
+"1:	cmpl	$1,(%eax)\n"
+"	js	1b\n"
+"\n"
+"	lock ; decl	(%eax)\n"
+"	js	__read_lock_failed\n"
+"	ret\n"
 );
 #endif
 




-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac21 #5 SMP Thu Mar 22 23:47:26 CET 2001 i686

