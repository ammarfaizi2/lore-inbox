Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVCKUKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVCKUKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVCKUIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:08:38 -0500
Received: from outmx020.isp.belgacom.be ([195.238.2.201]:5591 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261318AbVCKUFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:05:24 -0500
Message-ID: <4231F9F9.5080506@246tNt.com>
Date: Fri, 11 Mar 2005 21:05:13 +0100
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: [PATCH 1/2] MPC52xx updates : sparse clean-ups
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom & all

Here's some updates related to the Freescale MPC52xx. First some
clean-ups for sparse warnings and then PCI support. I'd like to get
theses approved & merged before I submit conversion to platform bus
model.

As usual, the patches can also be pulled of a bk repository :
bk://tnt.bkbits.net/linux-2.5-mpc52xx-pending

(note it's _NOT_ the same url as before even if it's close ;)



    Sylvain

---

diff -Nru a/arch/ppc/syslib/mpc52xx_pic.c b/arch/ppc/syslib/mpc52xx_pic.c
--- a/arch/ppc/syslib/mpc52xx_pic.c     2005-03-11 20:41:36 +01:00
+++ b/arch/ppc/syslib/mpc52xx_pic.c     2005-03-11 20:41:36 +01:00
@@ -33,8 +33,8 @@
 #include <asm/mpc52xx.h>


-static struct mpc52xx_intr *intr;
-static struct mpc52xx_sdma *sdma;
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_sdma __iomem *sdma;

 static void
 mpc52xx_ic_disable(unsigned int irq)
@@ -173,7 +173,7 @@
        mpc52xx_ic_disable,             /* disable(irq) */
        mpc52xx_ic_disable_and_ack,     /* disable_and_ack(irq) */
        mpc52xx_ic_end,                 /* end(irq) */
-       0                               /* set_affinity(irq, cpumask) 
SMP. */
+       NULL                            /* set_affinity(irq, cpumask) 
SMP. */
 };

 void __init
@@ -183,10 +183,8 @@
        u32 intr_ctrl;

        /* Remap the necessary zones */
-       intr = (struct mpc52xx_intr *)
-               ioremap(MPC52xx_INTR, sizeof(struct mpc52xx_intr));
-       sdma = (struct mpc52xx_sdma *)
-               ioremap(MPC52xx_SDMA, sizeof(struct mpc52xx_sdma));
+       intr = ioremap(MPC52xx_INTR, sizeof(struct mpc52xx_intr));
+       sdma = ioremap(MPC52xx_SDMA, sizeof(struct mpc52xx_sdma));

        if ((intr==NULL) || (sdma==NULL))
                panic("Can't ioremap PIC/SDMA register for init_irq !");
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2005-03-11 20:41:36 +01:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2005-03-11 20:41:36 +01:00
@@ -39,7 +39,8 @@
 void
 mpc52xx_restart(char *cmd)
 {
-       struct mpc52xx_gpt* gpt0 = (struct mpc52xx_gpt*) MPC52xx_GPTx(0);
+       struct mpc52xx_gpt __iomem *gpt0 =
+               (struct mpc52xx_gpt __iomem *) MPC52xx_GPTx(0);

        local_irq_disable();

@@ -102,7 +103,7 @@
 #endif

 static void
-mpc52xx_psc_putc(struct mpc52xx_psc * psc, unsigned char c)
+mpc52xx_psc_putc(struct mpc52xx_psc __iomem *psc, unsigned char c)
 {
        while (!(in_be16(&psc->mpc52xx_psc_status) &
                 MPC52xx_PSC_SR_TXRDY));
@@ -112,8 +113,9 @@
 void
 mpc52xx_progress(char *s, unsigned short hex)
 {
-       struct mpc52xx_psc *psc = (struct mpc52xx_psc *)MPC52xx_CONSOLE;
        char c;
+       struct mpc52xx_psc __iomem *psc =
+               (struct mpc52xx_psc __iomem *)MPC52xx_CONSOLE;

        while ((c = *s++) != 0) {
                if (c == '\n')
@@ -138,11 +140,11 @@
         * else get size from sdram config registers
         */
        if (ramsize == 0) {
-               struct mpc52xx_mmap_ctl *mmap_ctl;
+               struct mpc52xx_mmap_ctl __iomem *mmap_ctl;
                u32 sdram_config_0, sdram_config_1;

                /* Temp BAT2 mapping active when this is called ! */
-               mmap_ctl = (struct mpc52xx_mmap_ctl*) MPC52xx_MMAP_CTL;
+               mmap_ctl = (struct mpc52xx_mmap_ctl __iomem *) 
MPC52xx_MMAP_CTL;

                sdram_config_0 = in_be32(&mmap_ctl->sdram0);
                sdram_config_1 = in_be32(&mmap_ctl->sdram1);
@@ -169,13 +171,11 @@
        /* if bootloader didn't pass bus frequencies, calculate them */
        if (xlbfreq == 0) {
                /* Get RTC & Clock manager modules */
-               struct mpc52xx_rtc *rtc;
-               struct mpc52xx_cdm *cdm;
+               struct mpc52xx_rtc __iomem *rtc;
+               struct mpc52xx_cdm __iomem *cdm;

-               rtc = (struct mpc52xx_rtc*)
-                       ioremap(MPC52xx_RTC, sizeof(struct mpc52xx_rtc));
-               cdm = (struct mpc52xx_cdm*)
-                       ioremap(MPC52xx_CDM, sizeof(struct mpc52xx_cdm));
+               rtc = ioremap(MPC52xx_RTC, sizeof(struct mpc52xx_rtc));
+               cdm = ioremap(MPC52xx_CDM, sizeof(struct mpc52xx_cdm));

                if ((rtc==NULL) || (cdm==NULL))
                        panic("Can't ioremap RTC/CDM while computing bus 
freq");
@@ -212,8 +212,8 @@
                __res.bi_pcifreq = pcifreq;

                /* Release mapping */
-               iounmap((void*)rtc);
-               iounmap((void*)cdm);
+               iounmap(rtc);
+               iounmap(cdm);
        }

        divisor = 4;
diff -Nru a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c     2005-03-11 20:41:36 +01:00
+++ b/drivers/serial/mpc52xx_uart.c     2005-03-11 20:41:36 +01:00
@@ -86,7 +86,7 @@
         *        the console_init
         */

-#define PSC(port) ((struct mpc52xx_psc *)((port)->membase))
+#define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))


 /* Forward declaration of the interruption handling routine */
@@ -190,7 +190,7 @@
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
-       struct mpc52xx_psc *psc = PSC(port);
+       struct mpc52xx_psc __iomem *psc = PSC(port);

        /* Reset/activate the port, clear and enable interrupts */
        out_8(&psc->command,MPC52xx_PSC_RST_RX);
@@ -217,7 +217,7 @@
 static void
 mpc52xx_uart_shutdown(struct uart_port *port)
 {
-       struct mpc52xx_psc *psc = PSC(port);
+       struct mpc52xx_psc __iomem *psc = PSC(port);

        /* Shut down the port, interrupt and all */
        out_8(&psc->command,MPC52xx_PSC_RST_RX);
@@ -231,7 +231,7 @@
 mpc52xx_uart_set_termios(struct uart_port *port, struct termios *new,
                          struct termios *old)
 {
-       struct mpc52xx_psc *psc = PSC(port);
+       struct mpc52xx_psc __iomem *psc = PSC(port);
        unsigned long flags;
        unsigned char mr1, mr2;
        unsigned short ctr;
@@ -562,7 +562,7 @@
 mpc52xx_console_get_options(struct uart_port *port,
                             int *baud, int *parity, int *bits, int *flow)
 {
-       struct mpc52xx_psc *psc = PSC(port);
+       struct mpc52xx_psc __iomem *psc = PSC(port);
        unsigned char mr1;

        /* Read the mode registers */
@@ -592,7 +592,7 @@
 mpc52xx_console_write(struct console *co, const char *s, unsigned int 
count)
 {
        struct uart_port *port = &mpc52xx_uart_ports[co->index];
-       struct mpc52xx_psc *psc = PSC(port);
+       struct mpc52xx_psc __iomem *psc = PSC(port);
        unsigned int i, j;

        /* Disable interrupts */

