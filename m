Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbRFJAkA>; Sat, 9 Jun 2001 20:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbRFJAjv>; Sat, 9 Jun 2001 20:39:51 -0400
Received: from mailgate.indstate.edu ([139.102.15.118]:42641 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S263031AbRFJAjq>; Sat, 9 Jun 2001 20:39:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compiles warnings in 2.4.6pre2
Date: Sat, 9 Jun 2001 19:36:51 -0500
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <01060919365100.00648@kenobi>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes compile warnings when using gcc 3.0 cvs snapshots.  It  
makes the following changes:

- Removes warnings about trigraphs (done by patching the Makefile in top
  directory
- changes text at the end of #endif statements to comments
- fixes warnings about use of labels at the end of compound statements
- fixes a warning about no newline at the end of net/khttpd/security.h

Let me know if you have any questions or comments.

Rich

diff -urN -X dontdiff linux/Makefile rb/Makefile
--- linux/Makefile	Fri Jun  8 20:07:49 2001
+++ rb/Makefile	Sat Jun  9 11:15:02 2001
@@ -87,7 +87,7 @@
 
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
-CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strict-aliasing
+CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+          -fomit-frame-pointer -fno-strict-aliasing
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 #
diff -urN -X dontdiff linux/arch/i386/math-emu/fpu_trig.c 
rb/arch/i386/math-emu/fpu_trig.c
--- linux/arch/i386/math-emu/fpu_trig.c	Fri Apr  6 12:42:47 2001
+++ rb/arch/i386/math-emu/fpu_trig.c	Sat Jun  9 10:56:54 2001
@@ -1543,6 +1543,7 @@
 	  EXCEPTION(EX_INTERNAL | 0x116);
 	  return;
 #endif /* PARANOID */
+	  break;
 	}
     }
   else if ( (st0_tag == TAG_Valid) || (st0_tag == TW_Denormal) )
diff -urN -X dontdiff linux/drivers/atm/fore200e.c rb/drivers/atm/fore200e.c
--- linux/drivers/atm/fore200e.c	Fri Feb  9 14:30:22 2001
+++ rb/drivers/atm/fore200e.c	Sat Jun  9 10:57:44 2001
@@ -439,6 +439,7 @@
 
     case FORE200E_STATE_BLANK:
 	/* nothing to do for that state */
+	break;
     }
 }
 
diff -urN -X dontdiff linux/drivers/media/video/tuner.c 
rb/drivers/media/video/tuner.c
--- linux/drivers/media/video/tuner.c	Mon Feb 19 17:43:36 2001
+++ rb/drivers/media/video/tuner.c	Sat Jun  9 10:59:55 2001
@@ -558,6 +558,7 @@
 #endif
 	default:
 		/* nothing */
+		break;
 	}
 	
 	return 0;
diff -urN -X dontdiff linux/drivers/net/tokenring/ibmtr.c 
rb/drivers/net/tokenring/ibmtr.c
--- linux/drivers/net/tokenring/ibmtr.c	Tue Mar 20 15:05:00 2001
+++ rb/drivers/net/tokenring/ibmtr.c	Sat Jun  9 11:01:08 2001
@@ -1185,7 +1185,7 @@
 				isa_writeb(~CMD_IN_SRB, ti->mmio + ACA_OFFSET + ACA_RESET + ISRA_ODD);
 				isa_writeb(~SRB_RESP_INT, ti->mmio + ACA_OFFSET + ACA_RESET + ISRP_ODD);
 
-			  skip_reset:
+			  skip_reset:;
 			} /* SRB response */
 
 			if (status & ASB_FREE_INT) { /* ASB response */
diff -urN -X dontdiff linux/drivers/net/wan/hdlc.c rb/drivers/net/wan/hdlc.c
--- linux/drivers/net/wan/hdlc.c	Wed Apr 18 16:40:07 2001
+++ rb/drivers/net/wan/hdlc.c	Sat Jun  9 11:01:51 2001
@@ -1082,7 +1082,9 @@
 			}
 			break;
 
-		default:		/* to be defined */
+		default:
+			/* to be defined */
+			break;
 		}
 
 		dev_kfree_skb(skb);
diff -urN -X dontdiff linux/drivers/net/wan/sdla_fr.c 
rb/drivers/net/wan/sdla_fr.c
--- linux/drivers/net/wan/sdla_fr.c	Fri Apr 20 13:54:22 2001
+++ rb/drivers/net/wan/sdla_fr.c	Sat Jun  9 11:02:14 2001
@@ -4435,7 +4435,8 @@
 		trigger_fr_poll(dev);
 		
 		break;
-	default:  // ARP's and RARP's -- Shouldn't happen.
+	default:
+		break; // ARP's and RARP's -- Shouldn't happen.
 	}
 
 	return 0;	
diff -urN -X dontdiff linux/drivers/net/wan/sdla_x25.c 
rb/drivers/net/wan/sdla_x25.c
--- linux/drivers/net/wan/sdla_x25.c	Fri Apr 20 13:54:22 2001
+++ rb/drivers/net/wan/sdla_x25.c	Sat Jun  9 11:02:27 2001
@@ -3108,7 +3108,7 @@
 	case 0x08:	/* modem failure */
 #ifndef MODEM_NOT_LOG
 		printk(KERN_INFO "%s: modem failure!\n", card->devname);
-#endif MODEM_NOT_LOG
+#endif /* MODEM_NOT_LOG */
 		api_oob_event(card,mb);
 		break;
 
diff -urN -X dontdiff linux/drivers/scsi/NCR53c406a.c 
rb/drivers/scsi/NCR53c406a.c
--- linux/drivers/scsi/NCR53c406a.c	Tue Jun  5 15:49:09 2001
+++ rb/drivers/scsi/NCR53c406a.c	Sat Jun  9 11:06:38 2001
@@ -221,7 +221,7 @@
     (void *)0xc8000
 };
 #define ADDRESS_COUNT (sizeof( addresses ) / sizeof( unsigned ))
-#endif USE_BIOS
+#endif /* USE_BIOS */
 		       
 /* possible i/o port addresses */
 static unsigned short ports[] =
@@ -244,7 +244,7 @@
     { "Copyright (C) Acculogic, Inc.\r\n2.8M Diskette Extension Bios ver 
4.04.03 03/01/1993", 61, 82 },
 };
 #define SIGNATURE_COUNT (sizeof( signatures ) / sizeof( struct signature ))
-#endif USE_BIOS
+#endif /* USE_BIOS */
 
 /* ============================================================ */
 
@@ -347,7 +347,7 @@
     
     return tmp;
 }
-#endif USE_DMA
+#endif /* USE_DMA */
 
 #if USE_PIO
 static __inline__ int NCR53c406a_pio_read(unsigned char *request, 
@@ -455,7 +455,7 @@
     }
     return 0;
 }
-#endif USE_PIO
+#endif /* USE_PIO */
 
 int  __init 
 NCR53c406a_detect(Scsi_Host_Template * tpnt){
@@ -481,7 +481,7 @@
     }
     
     DEB(printk("NCR53c406a BIOS found at %X\n", (unsigned int) bios_base););
-#endif USE_BIOS
+#endif /* USE_BIOS */
     
 #ifdef PORT_BASE
     if (!request_region(port_base, 0x10, "NCR53c406a")) /* ports already 
snatched */
@@ -512,7 +512,7 @@
             }
         }
     }
-#endif PORT_BASE
+#endif /* PORT_BASE */
     
     if(!port_base){		/* no ports found */
         printk("NCR53c406a: no available ports found\n");
@@ -550,7 +550,7 @@
 #if USE_DMA
         printk("NCR53c406a: No interrupts found and DMA mode defined. Giving 
up.\n");
         goto err_release;
-#endif USE_DMA
+#endif /* USE_DMA */
     }
     else {
         DEB(printk("NCR53c406a: Shouldn't get here!\n"));
@@ -565,7 +565,7 @@
     }
     
     DEB(printk("Allocated DMA channel %d\n", dma_chan));
-#endif USE_DMA 
+#endif /* USE_DMA */
     
     tpnt->present = 1;
     tpnt->proc_name = "NCR53c406a";
@@ -820,8 +820,8 @@
     printk("\n");
 #else
     printk(", pio=%02x\n", pio_status);
-#endif USE_DMA
-#endif NCR53C406A_DEBUG
+#endif /* USE_DMA */
+#endif /* NCR53C406A_DEBUG */
     
     if(int_reg & 0x80){         /* SCSI reset intr */
         rtrc(3);
@@ -840,7 +840,7 @@
         current_SC->scsi_done(current_SC);
         return;
     }
-#endif USE_PIO
+#endif /* USE_PIO */
     
     if(status & 0x20) {		/* Parity error */
         printk("NCR53c406a: Warning: parity error!\n");
@@ -885,7 +885,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_write(current_SC->request_buffer, 
                                  current_SC->request_bufflen);
-#endif USE_DMA
+#endif /* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -900,7 +900,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif /* USE_PIO */
         }
         break;
         
@@ -914,7 +914,7 @@
 #if USE_DMA			/* No s/g support for DMA */
             NCR53c406a_dma_read(current_SC->request_buffer, 
                                 current_SC->request_bufflen);
-#endif USE_DMA
+#endif /* USE_DMA */
             outb(TRANSFER_INFO | DMA_OP, CMD_REG); 
 #if USE_PIO
             if (!current_SC->use_sg) /* Don't use scatter-gather */
@@ -929,7 +929,7 @@
                 }
             }
             REG0;
-#endif USE_PIO
+#endif /* USE_PIO */
         }
         break;
         
@@ -1011,7 +1011,7 @@
     
     return irq;
 }
-#endif IRQ_LEV
+#endif /* IRQ_LEV */
 
 static void chip_init()
 {
diff -urN -X dontdiff linux/drivers/scsi/aic7xxx_old.c 
rb/drivers/scsi/aic7xxx_old.c
--- linux/drivers/scsi/aic7xxx_old.c	Fri Apr 27 15:59:18 2001
+++ rb/drivers/scsi/aic7xxx_old.c	Sat Jun  9 11:07:04 2001
@@ -10100,7 +10100,7 @@
       } /* while(pdev=....) */
     } /* for PCI_DEVICES */
   } /* PCI BIOS present */
-#endif CONFIG_PCI
+#endif /* CONFIG_PCI */
 
 #if defined(__i386__) || defined(__alpha__)
   /*
diff -urN -X dontdiff linux/drivers/scsi/scsi.c rb/drivers/scsi/scsi.c
--- linux/drivers/scsi/scsi.c	Tue Jun  5 15:49:11 2001
+++ rb/drivers/scsi/scsi.c	Sat Jun  9 11:24:11 2001
@@ -2356,8 +2356,8 @@
 		/* The rest of these are not yet implemented. */
 	case MODULE_SCSI_CONST:
 	case MODULE_SCSI_IOCTL:
-		break;
 	default:
+		break;
 	}
 	return;
 }
diff -urN -X dontdiff linux/drivers/scsi/sym53c8xx.c 
rb/drivers/scsi/sym53c8xx.c
--- linux/drivers/scsi/sym53c8xx.c	Fri Apr 27 15:59:19 2001
+++ rb/drivers/scsi/sym53c8xx.c	Sat Jun  9 11:08:04 2001
@@ -11564,6 +11564,7 @@
 	OUTL_DSP (NCB_SCRIPT_PHYS (np, clrack));
 	return;
 out_stuck:
+	return;
 }
 
 
diff -urN -X dontdiff linux/drivers/sound/gus_wave.c 
rb/drivers/sound/gus_wave.c
--- linux/drivers/sound/gus_wave.c	Sun Nov 12 23:35:35 2000
+++ rb/drivers/sound/gus_wave.c	Sat Jun  9 11:09:21 2001
@@ -2102,6 +2102,7 @@
 			break;
 
 		default:
+			break;
 	}
 }
 
@@ -3282,6 +3283,7 @@
 		break;
 
 		default:
+			break;
 	}
 	restore_flags(flags);
 }
@@ -3423,6 +3425,7 @@
 				break;
 
 			default:
+				break;
 	}
 	status = gus_look8(0x49);	/*
 					 * Get Sampling IRQ Status
diff -urN -X dontdiff linux/drivers/sound/pss.c rb/drivers/sound/pss.c
--- linux/drivers/sound/pss.c	Sun Feb  4 13:05:29 2001
+++ rb/drivers/sound/pss.c	Sat Jun  9 11:09:44 2001
@@ -766,6 +766,7 @@
 			break;
 
 		default:
+			break;
 	}
 	return 0;
 }
diff -urN -X dontdiff linux/drivers/sound/wf_midi.c rb/drivers/sound/wf_midi.c
--- linux/drivers/sound/wf_midi.c	Sun Sep 17 11:45:07 2000
+++ rb/drivers/sound/wf_midi.c	Sat Jun  9 11:10:01 2001
@@ -231,6 +231,7 @@
 				break;
 		    
 			default:
+				break;
 			}
 		} else {
 			mi->m_prev_status = midic;
diff -urN -X dontdiff linux/drivers/sound/ymfpci.c rb/drivers/sound/ymfpci.c
--- linux/drivers/sound/ymfpci.c	Tue Jun  5 15:49:12 2001
+++ rb/drivers/sound/ymfpci.c	Sat Jun  9 11:10:27 2001
@@ -1829,6 +1829,7 @@
 		 * for instance we get SNDCTL_TMR_CONTINUE here.
 		 * XXX Is there sound_generic_ioctl() around?
 		 */
+		 break;
 	}
 	return -ENOTTY;
 }
diff -urN -X dontdiff linux/drivers/usb/net1080.c rb/drivers/usb/net1080.c
--- linux/drivers/usb/net1080.c	Tue Jun  5 15:49:12 2001
+++ rb/drivers/usb/net1080.c	Sat Jun  9 11:10:50 2001
@@ -599,7 +599,7 @@
 	}
 #ifdef	VERBOSE
 	dbg ("no read resubmitted");
-#endif	VERBOSE
+#endif	/* VERBOSE */
 }
 
 /*-------------------------------------------------------------------------*/
diff -urN -X dontdiff linux/fs/sysv/inode.c rb/fs/sysv/inode.c
--- linux/fs/sysv/inode.c	Wed Apr 18 01:16:39 2001
+++ rb/fs/sysv/inode.c	Sat Jun  9 11:11:22 2001
@@ -442,7 +442,7 @@
 			brelse(bh);
 			printk("SysV FS: cannot read superblock in %d byte mode\n", 
sb->sv_block_size);
 			goto failed;
-		superblock_ok:
+		superblock_ok:;
 		}
 	} else {
 		/* Switch to 512 block size. Unfortunately, we have to
diff -urN -X dontdiff linux/include/asm-i386/mca_dma.h 
rb/include/asm-i386/mca_dma.h
--- linux/include/asm-i386/mca_dma.h	Fri Jun  8 22:04:54 2001
+++ rb/include/asm-i386/mca_dma.h	Sat Jun  9 17:27:32 2001
@@ -199,4 +199,4 @@
 	outb(mode, MCA_DMA_REG_EXE);
 }
 
-#endif MCA_DMA_H
+#endif /* MCA_DMA_H */
diff -urN -X dontdiff linux/include/linux/coda_cache.h 
rb/include/linux/coda_cache.h
--- linux/include/linux/coda_cache.h	Tue Sep 19 17:08:59 2000
+++ rb/include/linux/coda_cache.h	Sat Jun  9 11:12:10 2001
@@ -19,4 +19,4 @@
 /* for downcalls and attributes and lookups */
 void coda_flag_inode_children(struct inode *inode, int flag);
 
-#endif _CFSNC_HEADER_
+#endif /* _CFSNC_HEADER_ */
diff -urN -X dontdiff linux/net/khttpd/security.h rb/net/khttpd/security.h
--- linux/net/khttpd/security.h	Wed Aug 18 11:45:10 1999
+++ rb/net/khttpd/security.h	Sat Jun  9 11:12:39 2001
@@ -9,4 +9,4 @@
 	char value[32-sizeof(void*)];  /* fill 1 cache-line */
 };
 
-#endif
\ No newline at end of file
+#endif

