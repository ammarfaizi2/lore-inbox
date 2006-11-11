Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947323AbWKKWlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947323AbWKKWlA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947324AbWKKWlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:41:00 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:62396 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S1754888AbWKKWky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:40:54 -0500
Message-id: <2259196751089514924@wsc.cz>
In-reply-to: <30973309282550314198@wsc.cz>
Subject: [PATCH 3/4] Char: cyclades, cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <support@cyclades.com>
Date: Sat, 11 Nov 2006 23:41:05 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cyclades, cleanup

- remove cvs rcsid and alter code that uses it.
- allow a semicolon after use of macro to not confuse parsers (e.g. indent)
  by do {} while (0)
- JIFFIES_DIFF is simple subtraction, subtract directly
- returns cleanup -- do not put values in parenthesis and do not return nothing
  at the end of void functions
- comments are /* */ in C (not //)

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 76495d5f78bf804b07f646abfbcb7a0a12938e11
tree 64678a10d342b5be363cce1200139f8be190318d
parent 55af131be8da830a1580ce56331e7388a1eebb95
author Jiri Slaby <jirislaby@gmail.com> Thu, 09 Nov 2006 21:58:58 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 09 Nov 2006 21:58:58 +0100

 drivers/char/cyclades.c |  133 ++++++++++++++++++-----------------------------
 1 files changed, 50 insertions(+), 83 deletions(-)

diff --git a/drivers/char/cyclades.c b/drivers/char/cyclades.c
index dd06880..f3efe85 100644
--- a/drivers/char/cyclades.c
+++ b/drivers/char/cyclades.c
@@ -1,7 +1,6 @@
 #undef	BLOCKMOVE
 #define	Z_WAKE
 #undef	Z_EXT_CHARS_IN_BUFFER
-static char rcsid[] = "$Revision: 2.3.2.20 $$Date: 2004/02/25 18:14:16 $";
 
 /*
  *  linux/drivers/char/cyclades.c
@@ -592,6 +591,8 @@ static char rcsid[] = "$Revision: 2.3.2.
  *
  */
 
+#define CY_VERSION	"2.4"
+
 /* If you need to install more boards than NR_CARDS, change the constant
    in the definition below. No other change is necessary to support up to
    eight boards. Beyond that you'll have to extend cy_isa_addresses. */
@@ -624,9 +625,9 @@ #undef	CY_ENABLE_MONITORING
 #undef	CY_PCI_DEBUG
 
 #if 0
-#define PAUSE __asm__("nop");
+#define PAUSE __asm__("nop")
 #else
-#define PAUSE ;
+#define PAUSE do {} while (0)
 #endif
 
 /*
@@ -697,8 +698,6 @@ #define WAKEUP_CHARS		256
 
 #define STD_COM_FLAGS (0)
 
-#define	JIFFIES_DIFF(n, j)	((j) - (n))
-
 static struct tty_driver *cy_serial_driver;
 
 #ifdef CONFIG_ISA
@@ -870,26 +869,22 @@ static inline int serial_paranoia_check(
 		char *name, const char *routine)
 {
 #ifdef SERIAL_PARANOIA_CHECK
-	static const char *badmagic =
-		"cyc Warning: bad magic number for serial struct (%s) in %s\n";
-	static const char *badinfo =
-		"cyc Warning: null cyclades_port for (%s) in %s\n";
-	static const char *badrange =
-		"cyc Warning: cyclades_port out of range for (%s) in %s\n";
-
 	if (!info) {
-		printk(badinfo, name, routine);
+		printk("cyc Warning: null cyclades_port for (%s) in %s\n",
+				name, routine);
 		return 1;
 	}
 
 	if ((long)info < (long)(&cy_port[0]) ||
 			(long)(&cy_port[NR_PORTS]) < (long)info) {
-		printk(badrange, name, routine);
+		printk("cyc Warning: cyclades_port out of range for (%s) in "
+				"%s\n", name, routine);
 		return 1;
 	}
 
 	if (info->magic != CYCLADES_MAGIC) {
-		printk(badmagic, name, routine);
+		printk("cyc Warning: bad magic number for serial struct (%s) "
+				"in %s\n", name, routine);
 		return 1;
 	}
 #endif
@@ -994,12 +989,12 @@ static int cyy_issue_cmd(void __iomem * 
 	/* if the CCR never cleared, the previous command
 	   didn't finish within the "reasonable time" */
 	if (i == 100)
-		return (-1);
+		return -1;
 
 	/* Issue the new command */
 	cy_writeb(base_addr + (CyCCR << index), cmd);
 
-	return (0);
+	return 0;
 }				/* cyy_issue_cmd */
 
 #ifdef CONFIG_ISA
@@ -1514,7 +1509,7 @@ cyz_fetch_msg(struct cyclades_card *cinf
 
 	firm_id = cinfo->base_addr + ID_ADDRESS;
 	if (!ISZLOADED(*cinfo)) {
-		return (-1);
+		return -1;
 	}
 	zfw_ctrl = cinfo->base_addr + (cy_readl(&firm_id->zfwctrl_addr) &
 			0xfffff);
@@ -1545,7 +1540,7 @@ cyz_issue_cmd(struct cyclades_card *cinf
 
 	firm_id = cinfo->base_addr + ID_ADDRESS;
 	if (!ISZLOADED(*cinfo)) {
-		return (-1);
+		return -1;
 	}
 	zfw_ctrl = cinfo->base_addr + (cy_readl(&firm_id->zfwctrl_addr) &
 			0xfffff);
@@ -1556,7 +1551,7 @@ cyz_issue_cmd(struct cyclades_card *cinf
 	    &((struct RUNTIME_9060 __iomem *)(cinfo->ctl_addr))->pci_doorbell;
 	while ((cy_readl(pci_doorbell) & 0xff) != 0) {
 		if (index++ == 1000) {
-			return ((int)(cy_readl(pci_doorbell) & 0xff));
+			return (int)(cy_readl(pci_doorbell) & 0xff);
 		}
 		udelay(50L);
 	}
@@ -1564,7 +1559,7 @@ cyz_issue_cmd(struct cyclades_card *cinf
 	cy_writel(&board_ctrl->hcmd_param, param);
 	cy_writel(pci_doorbell, (long)cmd);
 
-	return (0);
+	return 0;
 }				/* cyz_issue_cmd */
 
 static void
@@ -1962,8 +1957,6 @@ static void cyz_poll(unsigned long arg)
 		cyz_timerlist.expires = jiffies + cyz_polling_cycle;
 	}
 	add_timer(&cyz_timerlist);
-
-	return;
 }				/* cyz_poll */
 
 #endif				/* CONFIG_CYZ_INTR */
@@ -2321,7 +2314,6 @@ #endif
 #ifdef CY_DEBUG_OPEN
 	printk(" cyc shutdown done\n");
 #endif
-	return;
 }				/* shutdown */
 
 /*
@@ -2352,8 +2344,7 @@ block_til_ready(struct tty_struct *tty, 
 		if (info->flags & ASYNC_CLOSING) {
 			interruptible_sleep_on(&info->close_wait);
 		}
-		return ((info->
-			 flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return (info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN: -ERESTARTSYS;
 	}
 
 	/*
@@ -2632,8 +2623,7 @@ #endif
 	if (tty_hung_up_p(filp) || (info->flags & ASYNC_CLOSING)) {
 		if (info->flags & ASYNC_CLOSING)
 			interruptible_sleep_on(&info->close_wait);
-		return ((info->
-			 flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return (info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN: -ERESTARTSYS;
 	}
 
 	/*
@@ -2730,7 +2720,7 @@ #endif
 				break;
 		}
 	} else {
-		// Nothing to do!
+		/* Nothing to do! */
 	}
 	/* Run one more char cycle */
 	msleep_interruptible(jiffies_to_msecs(char_time * 5));
@@ -2872,7 +2862,6 @@ #ifdef CY_DEBUG_OTHER
 #endif
 
 	CY_UNLOCK(info, flags);
-	return;
 }				/* cy_close */
 
 /* This routine gets called when tty_write has put something into
@@ -3056,7 +3045,7 @@ #ifdef Z_EXT_CHARS_IN_BUFFER
 #ifdef CY_DEBUG_IO
 		printk("cyc:cy_chars_in_buffer ttyC%d %d\n", info->line, info->xmit_cnt + char_count);	/* */
 #endif
-		return (info->xmit_cnt + char_count);
+		return info->xmit_cnt + char_count;
 	}
 #endif				/* Z_EXT_CHARS_IN_BUFFER */
 }				/* cy_chars_in_buffer */
@@ -3921,7 +3910,7 @@ static int set_threshold(struct cyclades
 		cyy_issue_cmd(base_addr, CyCOR_CHANGE | CyCOR3ch, index);
 		CY_UNLOCK(info, flags);
 	} else {
-		// Nothing to do!
+		/* Nothing to do! */
 	}
 	return 0;
 }				/* set_threshold */
@@ -3945,7 +3934,7 @@ get_threshold(struct cyclades_port *info
 		tmp = cy_readb(base_addr + (CyCOR3 << index)) & CyREC_FIFO;
 		return put_user(tmp, value);
 	} else {
-		// Nothing to do!
+		/* Nothing to do! */
 		return 0;
 	}
 }				/* get_threshold */
@@ -3982,7 +3971,7 @@ static int set_timeout(struct cyclades_p
 		cy_writeb(base_addr + (CyRTPR << index), value & 0xff);
 		CY_UNLOCK(info, flags);
 	} else {
-		// Nothing to do!
+		/* Nothing to do! */
 	}
 	return 0;
 }				/* set_timeout */
@@ -4005,7 +3994,7 @@ static int get_timeout(struct cyclades_p
 		tmp = cy_readb(base_addr + (CyRTPR << index));
 		return put_user(tmp, value);
 	} else {
-		// Nothing to do!
+		/* Nothing to do! */
 		return 0;
 	}
 }				/* get_timeout */
@@ -4252,8 +4241,6 @@ #if 0
 	    (tty->termios->c_cflag & CLOCAL))
 		wake_up_interruptible(&info->open_wait);
 #endif
-
-	return;
 }				/* cy_set_termios */
 
 /* This function is used to send a high-priority XON/XOFF character to
@@ -4340,8 +4327,6 @@ #endif
 			info->throttle = 1;
 		}
 	}
-
-	return;
 }				/* cy_throttle */
 
 /*
@@ -4399,8 +4384,6 @@ #endif
 			info->throttle = 0;
 		}
 	}
-
-	return;
 }				/* cy_unthrottle */
 
 /* cy_start and cy_stop provide software output flow control as a
@@ -4437,10 +4420,8 @@ #endif
 			  cy_readb(base_addr + (CySRER << index)) & ~CyTxRdy);
 		CY_UNLOCK(info, flags);
 	} else {
-		// Nothing to do!
+		/* Nothing to do! */
 	}
-
-	return;
 }				/* cy_stop */
 
 static void cy_start(struct tty_struct *tty)
@@ -4473,10 +4454,8 @@ #endif
 			  cy_readb(base_addr + (CySRER << index)) | CyTxRdy);
 		CY_UNLOCK(info, flags);
 	} else {
-		// Nothing to do!
+		/* Nothing to do! */
 	}
-
-	return;
 }				/* cy_start */
 
 static void cy_flush_buffer(struct tty_struct *tty)
@@ -4664,7 +4643,7 @@ #endif
 	for (i = 0; i < NR_ISA_ADDRS; i++) {
 		unsigned int isa_address = cy_isa_addresses[i];
 		if (isa_address == 0x0000) {
-			return (nboard);
+			return nboard;
 		}
 
 		/* probe for CD1400... */
@@ -4694,7 +4673,7 @@ #endif
 			printk("but no more channels are available.\n");
 			printk("Change NR_PORTS in cyclades.c and recompile "
 					"kernel.\n");
-			return (nboard);
+			return nboard;
 		}
 		/* fill the next cy_card structure available */
 		for (j = 0; j < NR_CARDS; j++) {
@@ -4707,7 +4686,7 @@ #endif
 			printk("but no more cards can be used .\n");
 			printk("Change NR_CARDS in cyclades.c and recompile "
 					"kernel.\n");
-			return (nboard);
+			return nboard;
 		}
 
 		/* allocate IRQ */
@@ -4716,7 +4695,7 @@ #endif
 			printk("Cyclom-Y/ISA found at 0x%lx ",
 				(unsigned long)cy_isa_address);
 			printk("but could not allocate IRQ#%d.\n", cy_isa_irq);
-			return (nboard);
+			return nboard;
 		}
 
 		/* set cy_card */
@@ -4737,9 +4716,9 @@ #endif
 			cy_isa_nchan, cy_next_channel);
 		cy_next_channel += cy_isa_nchan;
 	}
-	return (nboard);
+	return nboard;
 #else
-	return (0);
+	return 0;
 #endif				/* CONFIG_ISA */
 }				/* cy_detect_isa */
 
@@ -4870,7 +4849,7 @@ #endif
 				printk("but no channels are available.\n");
 				printk("Change NR_PORTS in cyclades.c and "
 						"recompile kernel.\n");
-				return (i);
+				return i;
 			}
 			/* fill the next cy_card structure available */
 			for (j = 0; j < NR_CARDS; j++) {
@@ -4883,7 +4862,7 @@ #endif
 				printk("but no more cards can be used.\n");
 				printk("Change NR_CARDS in cyclades.c and "
 						"recompile kernel.\n");
-				return (i);
+				return i;
 			}
 
 			/* allocate IRQ */
@@ -4893,7 +4872,7 @@ #endif
 					(ulong) cy_pci_phys2);
 				printk("but could not allocate IRQ%d.\n",
 					cy_pci_irq);
-				return (i);
+				return i;
 			}
 
 			/* set cy_card */
@@ -5032,7 +5011,7 @@ #ifdef CY_PCI_DEBUG
 				cy_writel(&((struct RUNTIME_9060 *)
 					(cy_pci_addr0))->loc_addr_base,
 					WIN_CREG);
-				PAUSE
+				PAUSE;
 				printk("Cyclades-8Zo/PCI: FPGA id %lx, ver "
 					"%lx\n", (ulong) (0xff &
 					cy_readl(&((struct CUSTOM_REG *)
@@ -5053,7 +5032,7 @@ #endif
 			   ensures that the driver will not attempt to talk to
 			   the board until it has been properly initialized.
 			 */
-			PAUSE
+			PAUSE;
 			if ((mailbox == ZO_V1) || (mailbox == ZO_V2))
 				cy_writel(cy_pci_addr2 + ID_ADDRESS, 0L);
 
@@ -5067,7 +5046,7 @@ #endif
 					"no channels are available.\nChange "
 					"NR_PORTS in cyclades.c and recompile "
 					"kernel.\n", (ulong)cy_pci_phys2);
-				return (i);
+				return i;
 			}
 
 			/* fill the next cy_card structure available */
@@ -5080,7 +5059,7 @@ #endif
 					"no more cards can be used.\nChange "
 					"NR_CARDS in cyclades.c and recompile "
 					"kernel.\n", (ulong)cy_pci_phys2);
-				return (i);
+				return i;
 			}
 #ifdef CONFIG_CYZ_INTR
 			/* allocate IRQ only if board has an IRQ */
@@ -5092,7 +5071,7 @@ #ifdef CONFIG_CYZ_INTR
 						"but could not allocate "
 						"IRQ%d.\n", (ulong)cy_pci_phys2,
 						cy_pci_irq);
-					return (i);
+					return i;
 				}
 			}
 #endif				/* CONFIG_CYZ_INTR */
@@ -5152,7 +5131,7 @@ #ifdef CY_PCI_DEBUG
 		printk("Cyclades-Z/PCI: New Cyclades-Z board.  FPGA not "
 				"loaded\n");
 #endif
-		PAUSE
+		PAUSE;
 		/* This must be the new Cyclades-Ze/PCI. */
 		cy_pci_nchan = ZE_V1_NPORTS;
 
@@ -5161,7 +5140,7 @@ #endif
 				"are available.\nChange NR_PORTS in cyclades.c "
 				"and recompile kernel.\n",
 				(ulong) cy_pci_phys2);
-			return (i);
+			return i;
 		}
 
 		/* fill the next cy_card structure available */
@@ -5174,7 +5153,7 @@ #endif
 				"cards can be used.\nChange NR_CARDS in "
 				"cyclades.c and recompile kernel.\n",
 				(ulong) cy_pci_phys2);
-			return (i);
+			return i;
 		}
 #ifdef CONFIG_CYZ_INTR
 		/* allocate IRQ only if board has an IRQ */
@@ -5186,7 +5165,7 @@ #ifdef CONFIG_CYZ_INTR
 					(ulong) cy_pci_phys2);
 				printk("but could not allocate IRQ%d.\n",
 					cy_pci_irq);
-				return (i);
+				return i;
 			}
 		}
 #endif				/* CONFIG_CYZ_INTR */
@@ -5225,9 +5204,9 @@ #endif				/* CONFIG_CYZ_INTR */
 			"used.\nChange NR_CARDS in cyclades.c and recompile "
 			"kernel.\n", (unsigned int)Ze_phys2[0]);
 	}
-	return (i);
+	return i;
 #else
-	return (0);
+	return 0;
 #endif				/* ifdef CONFIG_PCI */
 }				/* cy_detect_pci */
 
@@ -5237,16 +5216,7 @@ #endif				/* ifdef CONFIG_PCI */
  */
 static inline void show_version(void)
 {
-	char *rcsvers, *rcsdate, *tmp;
-	rcsvers = strchr(rcsid, ' ');
-	rcsvers++;
-	tmp = strchr(rcsvers, ' ');
-	*tmp++ = '\0';
-	rcsdate = strchr(tmp, ' ');
-	rcsdate++;
-	tmp = strrchr(rcsdate, ' ');
-	*tmp = '\0';
-	printk("Cyclades driver %s %s\n", rcsvers, rcsdate);
+	printk("Cyclades driver " CY_VERSION "\n");
 	printk("        built %s %s\n", __DATE__, __TIME__);
 }				/* show_version */
 
@@ -5275,14 +5245,11 @@ cyclades_get_proc_info(char *buf, char *
 		if (info->count)
 			size = sprintf(buf + len, "%3d %8lu %10lu %8lu %10lu "
 				"%8lu %9lu %6ld\n", info->line,
-				JIFFIES_DIFF(info->idle_stats.in_use,
-					cur_jifs) / HZ,
+				(cur_jifs - info->idle_stats.in_use) / HZ,
 				info->idle_stats.xmit_bytes,
-				JIFFIES_DIFF(info->idle_stats.xmit_idle,
-					cur_jifs) / HZ,
+				(cur_jifs - info->idle_stats.xmit_idle) / HZ,
 				info->idle_stats.recv_bytes,
-				JIFFIES_DIFF(info->idle_stats.recv_idle,
-					cur_jifs) / HZ,
+				(cur_jifs - info->idle_stats.recv_idle) / HZ,
 				info->idle_stats.overruns,
 				(long)info->tty->ldisc.num);
 		else
