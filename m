Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268853AbTBZSNa>; Wed, 26 Feb 2003 13:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268862AbTBZSNa>; Wed, 26 Feb 2003 13:13:30 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:47822 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268853AbTBZSMv>; Wed, 26 Feb 2003 13:12:51 -0500
Date: Wed, 26 Feb 2003 19:19:16 +0100
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: rmk@arm.linux.org.uk
Subject: [RFC][PATCH] pcmcia: pass struct pcmcia_socket instead of socket nr to drivers
Message-ID: <20030226181916.GA21433@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the callbacks to the socket drivers so that not a
strange socket number is passed but a "struct pcmcia_socket *". This is
already of great help for pci_socket.c, for example; but it will become much
more important in future patches.

Tested on pci_socket.c, other x86-drivers only compile-checked...
hd64465_ss.c and sa1100-*.c don't compile currently anyway.

Comments & Feedback appreciated,

	Dominik

 drivers/pcmcia/cs.c          |   13 ++--
 drivers/pcmcia/cs_internal.h |    3 -
 drivers/pcmcia/hd64465_ss.c  |   65 +++++++++++-----------
 drivers/pcmcia/i82092.c      |  126 +++++++++++++++++++++++--------------------
 drivers/pcmcia/i82092aa.h    |   24 ++++----
 drivers/pcmcia/i82365.c      |   80 ++++++++++++++-------------
 drivers/pcmcia/pci_socket.c  |   83 ++++++++++++----------------
 drivers/pcmcia/pci_socket.h  |    2
 drivers/pcmcia/tcic.c        |   70 ++++++++++++-----------
 include/pcmcia/ss.h          |   46 ++++++++++-----
 10 files changed, 272 insertions(+), 240 deletions(-)

diff -ru linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-26 18:44:33.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-02-26 19:13:28.000000000 +0100
@@ -246,11 +246,11 @@
 {
 	int error;
 
-	if (handler && !try_module_get(s->ss_entry->owner))
+	if (handler && !try_module_get(s->sock->owner))
 		return -ENODEV;
 	error = s->ss_entry->register_callback(s->sock, handler, info);
 	if (!handler)
-		module_put(s->ss_entry->owner);
+		module_put(s->sock->owner);
 	return error;
 }
 
@@ -342,10 +342,13 @@
 	/* socket initialization */
 	for (i = 0; i < cls_d->nsock; i++) {
 		socket_info_t *s = &s_info[i];
+		struct pcmcia_socket *sock = &cls_d->socket[i];
+
+		sock->s_dev = dev;
+		sock->no = i;
 
 		s->ss_entry = cls_d->ops;
-		s->sock = i + cls_d->sock_offset;
-		s->s_dev = dev;
+		s->sock = sock;
 
 		/* base address = 0, map = 0 */
 		s->cis_mem.flags = 0;
@@ -369,7 +372,7 @@
 			sprintf(name, "%02d", j);
 			s->proc = proc_mkdir(name, proc_pccard);
 			if (s->proc)
-				s->ss_entry->proc_setup(i, s->proc);
+				s->ss_entry->proc_setup(s->sock, s->proc);
 #ifdef PCMCIA_DEBUG
 			if (s->proc)
 				create_proc_read_entry("clients", 0, s->proc,
diff -ru linux-original/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- linux-original/drivers/pcmcia/cs_internal.h	2003-02-26 18:44:33.000000000 +0100
+++ linux/drivers/pcmcia/cs_internal.h	2003-02-26 19:10:48.000000000 +0100
@@ -121,7 +121,6 @@
 typedef struct socket_info_t {
     spinlock_t			lock;
     struct pccard_operations *	ss_entry;
-    u_int			sock;
     socket_state_t		socket;
     socket_cap_t		cap;
     u_int			state;
@@ -159,7 +158,7 @@
     struct proc_dir_entry	*proc;
 #endif
 	int			use_bus_pm;
-	struct device		*s_dev;
+	struct pcmcia_socket	*sock;
 	/* TBD: integrate the following contents fully into this struct */
 	void			*ds_info; /* ds_socket_info */
 	int			socket_table_entry;
diff -ru linux-original/drivers/pcmcia/hd64465_ss.c linux/drivers/pcmcia/hd64465_ss.c
--- linux-original/drivers/pcmcia/hd64465_ss.c	2003-02-26 16:37:59.000000000 +0100
+++ linux/drivers/pcmcia/hd64465_ss.c	2003-02-26 19:14:33.000000000 +0100
@@ -89,6 +89,7 @@
 
 #define HS_MAX_SOCKETS 2
 static hs_socket_t hs_sockets[HS_MAX_SOCKETS];
+static struct pcmcia_socket p_socket[HS_MAX_SOCKETS];
 static spinlock_t hs_pending_event_lock = SPIN_LOCK_UNLOCKED;
 
 /* Calculate socket number from ptr into hs_sockets[] */
@@ -359,9 +360,9 @@
 
 /*============================================================*/
 
-static int hs_init(unsigned int sock)
+static int hs_init(struct pcmcia_socket *sock)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
 	
     	DPRINTK("hs_init(%d)\n", sock);
 	
@@ -375,9 +376,9 @@
 
 /*============================================================*/
 
-static int hs_suspend(unsigned int sock)
+static int hs_suspend(struct pcmcia_socket *sock)
 {
-    	DPRINTK("hs_suspend(%d)\n", sock);
+    	DPRINTK("hs_suspend(%d)\n", sock->no);
 
     	/* TODO */
 	
@@ -386,10 +387,10 @@
 
 /*============================================================*/
 
-static int hs_register_callback(unsigned int sock,
+static int hs_register_callback(struct pcmcia_socket *sock,
     	    void (*handler)(void *, unsigned int), void * info)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
 	
     	DPRINTK("hs_register_callback(%d)\n", sock);
 	sp->handler = handler;
@@ -399,9 +400,9 @@
 
 /*============================================================*/
 
-static int hs_inquire_socket(unsigned int sock, socket_cap_t *cap)
+static int hs_inquire_socket(struct pcmcia_socket *sock, socket_cap_t *cap)
 {
-    	DPRINTK("hs_inquire_socket(%d)\n", sock);
+    	DPRINTK("hs_inquire_socket(%d)\n", sock->no);
 
 	*cap = hs_socket_cap;
 	return 0;
@@ -409,9 +410,9 @@
 
 /*============================================================*/
 
-static int hs_get_status(unsigned int sock, u_int *value)
+static int hs_get_status(struct pcmcia_socket *sock, u_int *value)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
     	unsigned int isr;
 	u_int status = 0;
 	
@@ -465,7 +466,7 @@
 	    /* TODO: SS_STSCHG */
     	}	
 	
-    	DPRINTK("hs_get_status(%d) = %x\n", sock, status);
+    	DPRINTK("hs_get_status(%d) = %x\n", sock->no, status);
 	
 	*value = status;
 	return 0;
@@ -473,11 +474,11 @@
 
 /*============================================================*/
 
-static int hs_get_socket(unsigned int sock, socket_state_t *state)
+static int hs_get_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
 
-    	DPRINTK("hs_get_socket(%d)\n", sock);
+    	DPRINTK("hs_get_socket(%d)\n", sock->no);
 	
 	*state = sp->state;
 	return 0;
@@ -485,15 +486,15 @@
 
 /*============================================================*/
 
-static int hs_set_socket(unsigned int sock, socket_state_t *state)
+static int hs_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
     	u_long flags;
 	u_int changed;
 	unsigned short cscier;
 
     	DPRINTK("hs_set_socket(sock=%d, flags=%x, csc_mask=%x, Vcc=%d, Vpp=%d, io_irq=%d)\n",
-	    sock, state->flags, state->csc_mask, state->Vcc, state->Vpp, state->io_irq);
+	    sock->no, state->flags, state->csc_mask, state->Vcc, state->Vpp, state->io_irq);
 	
 	save_and_cli(flags);	/* Don't want interrupts happening here */
 
@@ -599,9 +600,9 @@
 
 /*============================================================*/
 
-static int hs_get_io_map(unsigned int sock, struct pccard_io_map *io)
+static int hs_get_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
 	int map = io->map;
 
     	DPRINTK("hs_get_io_map(%d, %d)\n", sock, map);
@@ -614,9 +615,9 @@
 
 /*============================================================*/
 
-static int hs_set_io_map(unsigned int sock, struct pccard_io_map *io)
+static int hs_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
 	int map = io->map;
 	struct pccard_io_map *sio;
 	pgprot_t prot;
@@ -696,9 +697,9 @@
 
 /*============================================================*/
 
-static int hs_get_mem_map(unsigned int sock, struct pccard_mem_map *mem)
+static int hs_get_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
 	int map = mem->map;
 
     	DPRINTK("hs_get_mem_map(%d, %d)\n", sock, map);
@@ -711,16 +712,16 @@
 
 /*============================================================*/
 
-static int hs_set_mem_map(unsigned int sock, struct pccard_mem_map *mem)
+static int hs_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-    	hs_socket_t *sp = &hs_sockets[sock];
+    	hs_socket_t *sp = &hs_sockets[sock->no];
 	struct pccard_mem_map *smem;
 	int map = mem->map;
 	unsigned long paddr, size;
 
 #if 0
     	DPRINTK("hs_set_mem_map(sock=%d, map=%d, flags=0x%x, sys_start=0x%08lx, sys_end=0x%08lx, card_start=0x%08x)\n",
-	    sock, map, mem->flags, mem->sys_start, mem->sys_stop, mem->card_start);
+	    sock->no, map, mem->flags, mem->sys_start, mem->sys_stop, mem->card_start);
 #endif
 
 	if (map >= MAX_WIN)
@@ -752,9 +753,9 @@
 
 /*============================================================*/
 
-static void hs_proc_setup(unsigned int sock, struct proc_dir_entry *base)
+static void hs_proc_setup(struct pcmcia_socket *sock, struct proc_dir_entry *base)
 {
-    	DPRINTK("hs_proc_setup(%d)\n", sock);
+    	DPRINTK("hs_proc_setup(%d)\n", sock->no);
 }
 
 /*============================================================*/
@@ -992,8 +993,9 @@
 }
 
 static struct pcmcia_socket_class_data hd64465_data = {
-	.nsock = HS_MAX_SOCKETS,
+	.nsock = (HS_MAX_SOCKETS - 1),
 	.ops = &hs_operations,
+	.socket = &p_socket[0],
 };
 
 static struct device_driver hd64465_driver = {
@@ -1068,11 +1070,14 @@
 		unregister_driver(&hd64465_driver);
 		return i;
 	}
+	for (i=0; i<HS_MAX_SOCKETS; i++)
+		p_socket[i].owner = THIS_MODULE
 
 /*	hd64465_io_debug = 0; */
-	platform_device_register(&hd64465_device);
 	hd64465_device.dev.class_data = &hd64465_data;
+	
 
+	platform_device_register(&hd64465_device);
 	return 0;
 }
 
diff -ru linux-original/drivers/pcmcia/i82092.c linux/drivers/pcmcia/i82092.c
--- linux-original/drivers/pcmcia/i82092.c	2003-02-26 16:37:59.000000000 +0100
+++ linux/drivers/pcmcia/i82092.c	2003-02-26 18:28:30.000000000 +0100
@@ -55,7 +55,6 @@
 
 /* the pccard structure and its functions */
 static struct pccard_operations i82092aa_operations = {
-	.owner			= THIS_MODULE,
 	.init 		 	= i82092aa_init,
 	.suspend	   	= i82092aa_suspend,
 	.register_callback 	= i82092aa_register_callback,
@@ -166,6 +165,17 @@
 	memset(cls_d, 0, sizeof(*cls_d));
 	cls_d->nsock = socket_count;
 	cls_d->ops = &i82092aa_operations;
+
+	cls_d->socket = kmalloc(socket_count * sizeof(struct pcmcia_socket), GFP_KERNEL);
+	if (!cls_d->socket) {
+		printk(KERN_ERR "i82092aa: kmalloc failed\n");
+		kfree(cls_d);
+		goto err_out_free_irq;
+	}
+	memset(cls_d->socket, 0, socket_count * sizeof(struct pcmcia_socket));
+	for (i=0; i<socket_count; i++)
+		cls_d->socket[i].owner = THIS_MODULE;
+
 	dev->dev.class_data = cls_d;
 
 	leave("i82092aa_pci_probe");
@@ -429,7 +439,7 @@
 
 
       
-static int i82092aa_init(unsigned int s)
+static int i82092aa_init(struct pcmcia_socket *sock)
 {
 	int i;
         pccard_io_map io = { 0, 0, 0, 0, 1 };
@@ -438,21 +448,21 @@
         enter("i82092aa_init");
                         
         mem.sys_stop = 0x0fff;
-        i82092aa_set_socket(s, &dead_socket);
+        i82092aa_set_socket(sock, &dead_socket);
         for (i = 0; i < 2; i++) {
         	io.map = i;
-                i82092aa_set_io_map(s, &io);
+                i82092aa_set_io_map(sock, &io);
 	}
         for (i = 0; i < 5; i++) {
         	mem.map = i;
-                i82092aa_set_mem_map(s, &mem);
+                i82092aa_set_mem_map(sock, &mem);
 	}
 	
 	leave("i82092aa_init");
 	return 0;
 }
                                                                                                                                                                                                                                               
-static int i82092aa_suspend(unsigned int sock)
+static int i82092aa_suspend(struct pcmcia_socket *sock)
 {
 	int retval;
 	enter("i82092aa_suspend");
@@ -461,31 +471,31 @@
         return retval;
 }
        
-static int i82092aa_register_callback(unsigned int sock, void (*handler)(void *, unsigned int), void * info)
+static int i82092aa_register_callback(struct pcmcia_socket *sock, void (*handler)(void *, unsigned int), void * info)
 {
 	enter("i82092aa_register_callback");
-	sockets[sock].handler = handler;
-        sockets[sock].info = info;
+	sockets[sock->no].handler = handler;
+        sockets[sock->no].info = info;
 	leave("i82092aa_register_callback");
 	return 0;
 } /* i82092aa_register_callback */
                                         
-static int i82092aa_inquire_socket(unsigned int sock, socket_cap_t *cap)
+static int i82092aa_inquire_socket(struct pcmcia_socket *sock, socket_cap_t *cap)
 {
 	enter("i82092aa_inquire_socket");
-	*cap = sockets[sock].cap;
+	*cap = sockets[sock->no].cap;
 	leave("i82092aa_inquire_socket");
 	return 0;
 } /* i82092aa_inquire_socket */
 
 
-static int i82092aa_get_status(unsigned int sock, u_int *value)
+static int i82092aa_get_status(struct pcmcia_socket *sock, u_int *value)
 {
 	unsigned int status;
 	
 	enter("i82092aa_get_status");
 	
-	status = indirect_read(sock,I365_STATUS); /* Interface Status Register */
+	status = indirect_read(sock->no,I365_STATUS); /* Interface Status Register */
 	*value = 0;
 	
 	if ((status & I365_CS_DETECT) == I365_CS_DETECT) {
@@ -494,7 +504,7 @@
 		
 	/* IO cards have a different meaning of bits 0,1 */
 	/* Also notice the inverse-logic on the bits */
-	 if (indirect_read(sock, I365_INTCTL) & I365_PC_IOCARD)	{
+	 if (indirect_read(sock->no, I365_INTCTL) & I365_PC_IOCARD)	{
 	 	/* IO card */
 	 	if (!(status & I365_CS_STSCHG))
 	 		*value |= SS_STSCHG;
@@ -521,7 +531,7 @@
 }
 
 
-static int i82092aa_get_socket(unsigned int sock, socket_state_t *state) 
+static int i82092aa_get_socket(struct pcmcia_socket *sock, socket_state_t *state) 
 {
 	unsigned char reg,vcc,vpp;
 	
@@ -533,7 +543,7 @@
 	state->csc_mask = 0;
 
 	/* First the power status of the socket */
-	reg = indirect_read(sock,I365_POWER); /* PCTRL - Power Control Register */
+	reg = indirect_read(sock->no,I365_POWER); /* PCTRL - Power Control Register */
 
 	if (reg & I365_PWR_AUTO)
 		state->flags |= SS_PWR_AUTO;  /* Automatic Power Switch */
@@ -559,7 +569,7 @@
 	
 	/* Now the IO card, RESET flags and IO interrupt */
 	
-	reg = indirect_read(sock, I365_INTCTL); /* IGENC, Interrupt and General Control */
+	reg = indirect_read(sock->no, I365_INTCTL); /* IGENC, Interrupt and General Control */
 	
 	if ((reg & I365_PC_RESET)==0)
 		state->flags |= SS_RESET;
@@ -567,11 +577,11 @@
 		state->flags |= SS_IOCARD; /* This is an IO card */
 	
 	/* Set the IRQ number */
-	if (sockets[sock].dev!=NULL)
-		state->io_irq = sockets[sock].dev->irq;
+	if (sockets[sock->no].dev!=NULL)
+		state->io_irq = sockets[sock->no].dev->irq;
 	
 	/* Card status change */
-	reg = indirect_read(sock, I365_CSCINT); /* CSCICR, Card Status Change Interrupt Configuration */
+	reg = indirect_read(sock->no, I365_CSCINT); /* CSCICR, Card Status Change Interrupt Configuration */
 	
 	if (reg & I365_CSC_DETECT) 
 		state->csc_mask |= SS_DETECT; /* Card detect is enabled */
@@ -592,7 +602,7 @@
 	return 0;
 }
 
-static int i82092aa_set_socket(unsigned int sock, socket_state_t *state) 
+static int i82092aa_set_socket(struct pcmcia_socket *sock, socket_state_t *state) 
 {
 	unsigned char reg;
 	
@@ -600,7 +610,7 @@
 	
 	/* First, set the global controller options */
 	
-	set_bridge_state(sock);
+	set_bridge_state(sock->no);
 	
 	/* Values for the IGENC register */
 	
@@ -610,7 +620,7 @@
 	if (state->flags & SS_IOCARD) 
 		reg = reg | I365_PC_IOCARD;
 		
-	indirect_write(sock,I365_INTCTL,reg); /* IGENC, Interrupt and General Control Register */
+	indirect_write(sock->no,I365_INTCTL,reg); /* IGENC, Interrupt and General Control Register */
 	
 	/* Power registers */
 	
@@ -629,7 +639,7 @@
 		case 0:	
 			break;
 		case 50: 
-			printk("setting voltage to Vcc to 5V on socket %i\n",sock);
+			printk("setting voltage to Vcc to 5V on socket %i\n",sock->no);
 			reg |= I365_VCC_5V;
 			break;
 		default:
@@ -641,10 +651,10 @@
 	
 	switch (state->Vpp) {
 		case 0:	
-			printk("not setting Vpp on socket %i\n",sock);
+			printk("not setting Vpp on socket %i\n",sock->no);
 			break;
 		case 50: 
-			printk("setting Vpp to 5.0 for socket %i\n",sock);
+			printk("setting Vpp to 5.0 for socket %i\n",sock->no);
 			reg |= I365_VPP1_5V | I365_VPP2_5V;
 			break;
 		case 120: 
@@ -657,8 +667,8 @@
 			return -EINVAL;
 	}
 	
-	if (reg != indirect_read(sock,I365_POWER)) /* only write if changed */
-		indirect_write(sock,I365_POWER,reg);
+	if (reg != indirect_read(sock->no,I365_POWER)) /* only write if changed */
+		indirect_write(sock->no,I365_POWER,reg);
 		
 	/* Enable specific interrupt events */
 	
@@ -681,14 +691,14 @@
 	
 	/* now write the value and clear the (probably bogus) pending stuff by doing a dummy read*/
 	
-	indirect_write(sock,I365_CSCINT,reg);
-	(void)indirect_read(sock,I365_CSC);
+	indirect_write(sock->no,I365_CSCINT,reg);
+	(void)indirect_read(sock->no,I365_CSC);
 
 	leave("i82092aa_set_socket");
 	return 0;
 }
 
-static int i82092aa_get_io_map(unsigned int sock, struct pccard_io_map *io)
+static int i82092aa_get_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
 	unsigned char map, ioctl, addr;
 	
@@ -700,11 +710,11 @@
 	}
 	
 	/* FIXME: How does this fit in with the PCI resource (re)allocation */
-	io->start = indirect_read16(sock, I365_IO(map)+I365_W_START);
-	io->stop  = indirect_read16(sock, I365_IO(map)+I365_W_START);
+	io->start = indirect_read16(sock->no, I365_IO(map)+I365_W_START);
+	io->stop  = indirect_read16(sock->no, I365_IO(map)+I365_W_START);
 	
-	ioctl = indirect_read(sock,I365_IOCTL); /* IOCREG: I/O Control Register */
-	addr  = indirect_read(sock,I365_ADDRWIN); /* */
+	ioctl = indirect_read(sock->no,I365_IOCTL); /* IOCREG: I/O Control Register */
+	addr  = indirect_read(sock->no,I365_ADDRWIN); /* */
 	
 	io->speed = to_ns(ioctl & I365_IOCTL_WAIT(map)) ? 1 : 0; /* check this out later */
 	io->flags = 0;
@@ -716,7 +726,7 @@
 	return 0;
 }
 
-static int i82092aa_set_io_map(unsigned sock, struct pccard_io_map *io)
+static int i82092aa_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
 	unsigned char map, ioctl;
 	
@@ -735,31 +745,31 @@
 	}
 
 	/* Turn off the window before changing anything */ 
-	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_IO(map))
-		indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
+	if (indirect_read(sock->no, I365_ADDRWIN) & I365_ENA_IO(map))
+		indirect_resetbit(sock->no, I365_ADDRWIN, I365_ENA_IO(map));
 
 /*	printk("set_io_map: Setting range to %x - %x \n",io->start,io->stop);  */
 	
 	/* write the new values */
-	indirect_write16(sock,I365_IO(map)+I365_W_START,io->start);            	
-	indirect_write16(sock,I365_IO(map)+I365_W_STOP,io->stop);            	
+	indirect_write16(sock->no,I365_IO(map)+I365_W_START,io->start);            	
+	indirect_write16(sock->no,I365_IO(map)+I365_W_STOP,io->stop);            	
 	            	
-	ioctl = indirect_read(sock,I365_IOCTL) & ~I365_IOCTL_MASK(map);
+	ioctl = indirect_read(sock->no,I365_IOCTL) & ~I365_IOCTL_MASK(map);
 	
 	if (io->flags & (MAP_16BIT|MAP_AUTOSZ))
 		ioctl |= I365_IOCTL_16BIT(map);
 		
-	indirect_write(sock,I365_IOCTL,ioctl);
+	indirect_write(sock->no,I365_IOCTL,ioctl);
 	
 	/* Turn the window back on if needed */
 	if (io->flags & MAP_ACTIVE)
-		indirect_setbit(sock,I365_ADDRWIN,I365_ENA_IO(map));
+		indirect_setbit(sock->no,I365_ADDRWIN,I365_ENA_IO(map));
 			
 	leave("i82092aa_set_io_map");	
 	return 0;
 }
 
-static int i82092aa_get_mem_map(unsigned sock, struct pccard_mem_map *mem)
+static int i82092aa_get_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
 	unsigned short base, i;
 	unsigned char map, addr;
@@ -774,7 +784,7 @@
 		return -EINVAL;
 	}
 	
-	addr = indirect_read(sock, I365_ADDRWIN);
+	addr = indirect_read(sock->no, I365_ADDRWIN);
 		
 	if (addr & I365_ENA_MEM(map))
 		mem->flags |= MAP_ACTIVE;		/* yes this mapping is active */
@@ -783,7 +793,7 @@
 	
 	/* Find the start address - this register also has mapping info */
 	
-	i = indirect_read16(sock,base+I365_W_START);
+	i = indirect_read16(sock->no,base+I365_W_START);
 	if (i & I365_MEM_16BIT)
 		mem->flags |= MAP_16BIT;
 	if (i & I365_MEM_0WS)
@@ -792,7 +802,7 @@
 	mem->sys_start = ((unsigned long)(i & 0x0fff) << 12);
 	
 	/* Find the end address - this register also has speed info */
-	i = indirect_read16(sock,base+I365_W_STOP);
+	i = indirect_read16(sock->no,base+I365_W_STOP);
 	if (i & I365_MEM_WS0)
 		mem->speed = 1;
 	if (i & I365_MEM_WS1)
@@ -802,7 +812,7 @@
 	
 	/* Find the card start address, also some more MAP attributes */
 	
-	i = indirect_read16(sock, base+I365_W_OFF);
+	i = indirect_read16(sock->no, base+I365_W_OFF);
 	if (i & I365_MEM_WRPROT)
 		mem->flags |= MAP_WRPROT;
 	if (i & I365_MEM_REG)
@@ -810,14 +820,14 @@
 	mem->card_start = ( (unsigned long)(i & 0x3fff)<12) + mem->sys_start;
 	mem->card_start &=  0x3ffffff;
 	
-	printk("Card %i is from %lx to %lx \n",sock,mem->sys_start,mem->sys_stop);
+	printk("Card %i is from %lx to %lx \n",sock->no,mem->sys_start,mem->sys_stop);
 	
 	leave("i82092aa_get_mem_map");
 	return 0;
 	
 }
 
-static int i82092aa_set_mem_map(unsigned sock, struct pccard_mem_map *mem)
+static int i82092aa_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
 	unsigned short base, i;
 	unsigned char map;
@@ -834,13 +844,13 @@
 	if ( (mem->card_start > 0x3ffffff) || (mem->sys_start > mem->sys_stop) ||
 	     (mem->speed > 1000) ) {
 		leave("i82092aa_set_mem_map: invalid address / speed");
-		printk("invalid mem map for socket %i : %lx to %lx with a start of %x \n",sock,mem->sys_start, mem->sys_stop, mem->card_start);
+		printk("invalid mem map for socket %i : %lx to %lx with a start of %x \n",sock->no,mem->sys_start, mem->sys_stop, mem->card_start);
 		return -EINVAL;
 	}
 	
 	/* Turn off the window before changing anything */
-	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_MEM(map))
-	              indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
+	if (indirect_read(sock->no, I365_ADDRWIN) & I365_ENA_MEM(map))
+	              indirect_resetbit(sock->no, I365_ADDRWIN, I365_ENA_MEM(map));
 	                 
 	                 
 /* 	printk("set_mem_map: Setting map %i range to %x - %x on socket %i, speed is %i, active = %i \n",map, mem->sys_start,mem->sys_stop,sock,mem->speed,mem->flags & MAP_ACTIVE);  */
@@ -852,7 +862,7 @@
 		i |= I365_MEM_16BIT;
 	if (mem->flags & MAP_0WS)
 		i |= I365_MEM_0WS;	
-	indirect_write16(sock,base+I365_W_START,i);
+	indirect_write16(sock->no,base+I365_W_START,i);
 		               
 	/* write the stop address */
 	
@@ -871,7 +881,7 @@
 			break;
 	}
 	
-	indirect_write16(sock,base+I365_W_STOP,i);
+	indirect_write16(sock->no,base+I365_W_STOP,i);
 	
 	/* card start */
 	
@@ -884,17 +894,17 @@
 	} else {
 /*		printk("requesting normal memory for socket %i\n",sock);*/
 	}
-	indirect_write16(sock,base+I365_W_OFF,i);
+	indirect_write16(sock->no,base+I365_W_OFF,i);
 	
 	/* Enable the window if necessary */
 	if (mem->flags & MAP_ACTIVE)
-		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
+		indirect_setbit(sock->no, I365_ADDRWIN, I365_ENA_MEM(map));
 	            
 	leave("i82092aa_set_mem_map");
 	return 0;
 }
 
-static void i82092aa_proc_setup(unsigned int sock, struct proc_dir_entry *base)
+static void i82092aa_proc_setup(struct pcmcia_socket *sock, struct proc_dir_entry *base)
 {
 	
 }
diff -ru linux-original/drivers/pcmcia/i82092aa.h linux/drivers/pcmcia/i82092aa.h
--- linux-original/drivers/pcmcia/i82092aa.h	2003-02-26 16:37:59.000000000 +0100
+++ linux/drivers/pcmcia/i82092aa.h	2003-02-26 17:56:41.000000000 +0100
@@ -26,18 +26,18 @@
 
 
 
-static int i82092aa_get_status(unsigned int sock, u_int *value);
-static int i82092aa_get_socket(unsigned int sock, socket_state_t *state);
-static int i82092aa_set_socket(unsigned int sock, socket_state_t *state);
-static int i82092aa_get_io_map(unsigned int sock, struct pccard_io_map *io);
-static int i82092aa_set_io_map(unsigned int sock, struct pccard_io_map *io);
-static int i82092aa_get_mem_map(unsigned int sock, struct pccard_mem_map *mem);
-static int i82092aa_set_mem_map(unsigned int sock, struct pccard_mem_map *mem);
-static int i82092aa_init(unsigned int s);
-static int i82092aa_suspend(unsigned int sock);
-static int i82092aa_register_callback(unsigned int sock, void (*handler)(void *, unsigned int), void * info);
-static int i82092aa_inquire_socket(unsigned int sock, socket_cap_t *cap);
-static void i82092aa_proc_setup(unsigned int sock, struct proc_dir_entry *base);
+static int i82092aa_get_status(struct pcmcia_socket *sock, u_int *value);
+static int i82092aa_get_socket(struct pcmcia_socket *sock, socket_state_t *state);
+static int i82092aa_set_socket(struct pcmcia_socket *sock, socket_state_t *state);
+static int i82092aa_get_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io);
+static int i82092aa_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io);
+static int i82092aa_get_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem);
+static int i82092aa_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem);
+static int i82092aa_init(struct pcmcia_socket *sock);
+static int i82092aa_suspend(struct pcmcia_socket *sock);
+static int i82092aa_register_callback(struct pcmcia_socket *sock, void (*handler)(void *, unsigned int), void * info);
+static int i82092aa_inquire_socket(struct pcmcia_socket *sock, socket_cap_t *cap);
+static void i82092aa_proc_setup(struct pcmcia_socket *sock, struct proc_dir_entry *base);
 
 #endif
 
diff -ru linux-original/drivers/pcmcia/i82365.c linux/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-02-26 18:44:42.000000000 +0100
+++ linux/drivers/pcmcia/i82365.c	2003-02-26 18:36:16.000000000 +0100
@@ -186,6 +186,7 @@
 static socket_info_t socket[8] = {
     { 0, }, /* ... */
 };
+static struct pcmcia_socket p_socket[8];
 
 /* Default ISA interrupt mask */
 #define I365_MASK	0xdeb8	/* irq 15,14,12,11,10,9,7,5,4,3 */
@@ -1014,18 +1015,18 @@
 
 /*====================================================================*/
 
-static int pcic_register_callback(unsigned int sock, void (*handler)(void *, unsigned int), void * info)
+static int pcic_register_callback(struct pcmcia_socket *sock, void (*handler)(void *, unsigned int), void * info)
 {
-    socket[sock].handler = handler;
-    socket[sock].info = info;
+    socket[sock->no].handler = handler;
+    socket[sock->no].info = info;
     return 0;
 } /* pcic_register_callback */
 
 /*====================================================================*/
 
-static int pcic_inquire_socket(unsigned int sock, socket_cap_t *cap)
+static int pcic_inquire_socket(struct pcmcia_socket *sock, socket_cap_t *cap)
 {
-    *cap = socket[sock].cap;
+    *cap = socket[sock->no].cap;
     return 0;
 } /* pcic_inquire_socket */
 
@@ -1430,9 +1431,9 @@
     return (p - buf);
 }
 
-static void pcic_proc_setup(unsigned int sock, struct proc_dir_entry *base)
+static void pcic_proc_setup(struct pcmcia_socket *sock, struct proc_dir_entry *base)
 {
-    socket_info_t *s = &socket[sock];
+    socket_info_t *s = &socket[sock->no];
 
     if (s->flags & IS_ALIVE)
     	return;
@@ -1480,90 +1481,89 @@
 #endif
 	
 
-static int pcic_get_status(unsigned int sock, u_int *value)
+static int pcic_get_status(struct pcmcia_socket *sock, u_int *value)
 {
-	if (socket[sock].flags & IS_ALIVE) {
+	if (socket[sock->no].flags & IS_ALIVE) {
 		*value = 0;
 		return -EINVAL;
 	}
 
-	LOCKED(i365_get_status(sock, value));
+	LOCKED(i365_get_status(sock->no, value));
 }
 
-static int pcic_get_socket(unsigned int sock, socket_state_t *state)
+static int pcic_get_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-	if (socket[sock].flags & IS_ALIVE)
+	if (socket[sock->no].flags & IS_ALIVE)
 		return -EINVAL;
 
-	LOCKED(i365_get_socket(sock, state));
+	LOCKED(i365_get_socket(sock->no, state));
 }
 
-static int pcic_set_socket(unsigned int sock, socket_state_t *state)
+static int pcic_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-	if (socket[sock].flags & IS_ALIVE)
+	if (socket[sock->no].flags & IS_ALIVE)
 		return -EINVAL;
 
-	LOCKED(i365_set_socket(sock, state));
+	LOCKED(i365_set_socket(sock->no, state));
 }
 
-static int pcic_get_io_map(unsigned int sock, struct pccard_io_map *io)
+static int pcic_get_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-	if (socket[sock].flags & IS_ALIVE)
+	if (socket[sock->no].flags & IS_ALIVE)
 		return -EINVAL;
 
-	LOCKED(i365_get_io_map(sock, io));
+	LOCKED(i365_get_io_map(sock->no, io));
 }
 
-static int pcic_set_io_map(unsigned int sock, struct pccard_io_map *io)
+static int pcic_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-	if (socket[sock].flags & IS_ALIVE)
+	if (socket[sock->no].flags & IS_ALIVE)
 		return -EINVAL;
 
-	LOCKED(i365_set_io_map(sock, io));
+	LOCKED(i365_set_io_map(sock->no, io));
 }
 
-static int pcic_get_mem_map(unsigned int sock, struct pccard_mem_map *mem)
+static int pcic_get_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-	if (socket[sock].flags & IS_ALIVE)
+	if (socket[sock->no].flags & IS_ALIVE)
 		return -EINVAL;
 
-	LOCKED(i365_get_mem_map(sock, mem));
+	LOCKED(i365_get_mem_map(sock->no, mem));
 }
 
-static int pcic_set_mem_map(unsigned int sock, struct pccard_mem_map *mem)
+static int pcic_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-	if (socket[sock].flags & IS_ALIVE)
+	if (socket[sock->no].flags & IS_ALIVE)
 		return -EINVAL;
 
-	LOCKED(i365_set_mem_map(sock, mem));
+	LOCKED(i365_set_mem_map(sock->no, mem));
 }
 
-static int pcic_init(unsigned int s)
+static int pcic_init(struct pcmcia_socket *sock)
 {
 	int i;
 	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { 0, 0, 0, 0, 0, 0 };
 
 	mem.sys_stop = 0x1000;
-	pcic_set_socket(s, &dead_socket);
+	pcic_set_socket(sock, &dead_socket);
 	for (i = 0; i < 2; i++) {
 		io.map = i;
-		pcic_set_io_map(s, &io);
+		pcic_set_io_map(sock, &io);
 	}
 	for (i = 0; i < 5; i++) {
 		mem.map = i;
-		pcic_set_mem_map(s, &mem);
+		pcic_set_mem_map(sock, &mem);
 	}
 	return 0;
 }
 
-static int pcic_suspend(unsigned int sock)
+static int pcic_suspend(struct pcmcia_socket *sock)
 {
 	return pcic_set_socket(sock, &dead_socket);
 }
 
 static struct pccard_operations pcic_operations = {
-	.owner			= THIS_MODULE,
 	.init			= pcic_init,
 	.suspend		= pcic_suspend,
 	.register_callback	= pcic_register_callback,
@@ -1582,6 +1582,7 @@
 
 static struct pcmcia_socket_class_data i82365_data = {
 	.ops = &pcic_operations,
+	.socket = &p_socket[0],
 };
 
 static struct device_driver i82365_driver = {
@@ -1601,6 +1602,8 @@
 static int __init init_i82365(void)
 {
     servinfo_t serv;
+    unsigned int i;
+
     pcmcia_get_card_services_info(&serv);
     if (serv.Revision != CS_RELEASE_CODE) {
 	printk(KERN_NOTICE "i82365: Card Services release "
@@ -1628,11 +1631,14 @@
 	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
 #endif
     
-    platform_device_register(&i82365_device);
-
     i82365_data.nsock = sockets;
     i82365_device.dev.class_data = &i82365_data;
-    
+
+    for (i=0; i<sockets; i++)
+	    p_socket[i].owner = THIS_MODULE;
+
+    platform_device_register(&i82365_device);
+
     /* Finally, schedule a polling interrupt */
     if (poll_interval != 0) {
 	poll_timer.function = pcic_interrupt_wrapper;
diff -ru linux-original/drivers/pcmcia/pci_socket.c linux/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-26 16:37:59.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.c	2003-02-26 18:15:29.000000000 +0100
@@ -39,47 +39,46 @@
  * Arbitrary define. This is the array of active cardbus
  * entries.
  */
-#define MAX_SOCKETS (8)
-static pci_socket_t pci_socket_array[MAX_SOCKETS];
 
-static int pci_init_socket(unsigned int sock)
+static int pci_init_socket(struct pcmcia_socket *sock)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->init)
 		return socket->op->init(socket);
 	return -EINVAL;
 }
 
-static int pci_suspend_socket(unsigned int sock)
+static int pci_suspend_socket(struct pcmcia_socket *sock)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->suspend)
 		return socket->op->suspend(socket);
 	return -EINVAL;
 }
 
-static int pci_register_callback(unsigned int sock, void (*handler)(void *, unsigned int), void * info)
+static int pci_register_callback(struct pcmcia_socket *sock, void (*handler)(void *, unsigned int), void * info)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	socket->handler = handler;
 	socket->info = info;
 	return 0;
 }
 
-static int pci_inquire_socket(unsigned int sock, socket_cap_t *cap)
+static int pci_inquire_socket(struct pcmcia_socket *sock, socket_cap_t *cap)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	*cap = socket->cap;
 	return 0;
 }
 
-static int pci_get_status(unsigned int sock, unsigned int *value)
+static int pci_get_status(struct pcmcia_socket *sock, unsigned int *value)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->get_status)
 		return socket->op->get_status(socket, value);
@@ -87,70 +86,67 @@
 	return -EINVAL;
 }
 
-static int pci_get_socket(unsigned int sock, socket_state_t *state)
+static int pci_get_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->get_socket)
 		return socket->op->get_socket(socket, state);
 	return -EINVAL;
 }
 
-static int pci_set_socket(unsigned int sock, socket_state_t *state)
+static int pci_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
-
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 	if (socket->op && socket->op->set_socket)
 		return socket->op->set_socket(socket, state);
 	return -EINVAL;
 }
 
-static int pci_get_io_map(unsigned int sock, struct pccard_io_map *io)
+static int pci_get_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
-
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 	if (socket->op && socket->op->get_io_map)
 		return socket->op->get_io_map(socket, io);
 	return -EINVAL;
 }
 
-static int pci_set_io_map(unsigned int sock, struct pccard_io_map *io)
+static int pci_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->set_io_map)
 		return socket->op->set_io_map(socket, io);
 	return -EINVAL;
 }
 
-static int pci_get_mem_map(unsigned int sock, struct pccard_mem_map *mem)
+static int pci_get_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->get_mem_map)
 		return socket->op->get_mem_map(socket, mem);
 	return -EINVAL;
 }
 
-static int pci_set_mem_map(unsigned int sock, struct pccard_mem_map *mem)
+static int pci_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->set_mem_map)
 		return socket->op->set_mem_map(socket, mem);
 	return -EINVAL;
 }
 
-static void pci_proc_setup(unsigned int sock, struct proc_dir_entry *base)
+static void pci_proc_setup(struct pcmcia_socket *sock, struct proc_dir_entry *base)
 {
-	pci_socket_t *socket = pci_socket_array + sock;
+	pci_socket_t *socket = pci_get_drvdata(container_of(sock->s_dev, struct pci_dev, dev));
 
 	if (socket->op && socket->op->proc_setup)
 		socket->op->proc_setup(socket, base);
 }
 
 static struct pccard_operations pci_socket_operations = {
-	.owner			= THIS_MODULE,
 	.init			= pci_init_socket,
 	.suspend		= pci_suspend_socket,
 	.register_callback	= pci_register_callback,
@@ -165,24 +161,31 @@
 	.proc_setup		= pci_proc_setup,
 };
 
-static int __devinit add_pci_socket(int nr, struct pci_dev *dev, struct pci_socket_ops *ops)
+static int __devinit
+cardbus_probe (struct pci_dev *dev, const struct pci_device_id *id)
 {
-	pci_socket_t *socket = nr + pci_socket_array;
+	pci_socket_t *socket;
 	int err;
 	
+	socket = kmalloc(sizeof(*socket), GFP_KERNEL);
+	if (!socket)
+		return -ENOMEM;
 	memset(socket, 0, sizeof(*socket));
 
 	/* prepare class_data */
-	socket->cls_d.sock_offset = nr;
 	socket->cls_d.nsock = 1; /* yenta is 1, no other low-level driver uses
 			     this yet */
 	socket->cls_d.ops = &pci_socket_operations;
 	socket->cls_d.use_bus_pm = 1;
+
+	socket->p_sock.owner = THIS_MODULE;
+	socket->cls_d.socket = &socket->p_sock;
+
 	dev->dev.class_data = &socket->cls_d;
 
 	/* prepare pci_socket_t */
 	socket->dev = dev;
-	socket->op = ops;
+	socket->op = &yenta_operations;
 	pci_set_drvdata(dev, socket);
 	spin_lock_init(&socket->event_lock);
 	err = socket->op->open(socket);
@@ -199,19 +202,6 @@
 	return 0;
 }
 
-static int __devinit
-cardbus_probe (struct pci_dev *dev, const struct pci_device_id *id)
-{
-	int	s;
-
-	for (s = 0; s < MAX_SOCKETS; s++) {
-		if (pci_socket_array [s].dev == 0) {
-			return add_pci_socket (s, dev, &yenta_operations);
-		}
-	}
-	return -ENODEV;
-}
-
 static void __devexit cardbus_remove (struct pci_dev *dev)
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
@@ -220,6 +210,7 @@
 	if (socket->op && socket->op->close)
 		socket->op->close(socket);
 	pci_set_drvdata(dev, NULL);
+	kfree(socket);
 }
 
 static int cardbus_suspend (struct pci_dev *dev, u32 state)
diff -ru linux-original/drivers/pcmcia/pci_socket.h linux/drivers/pcmcia/pci_socket.h
--- linux-original/drivers/pcmcia/pci_socket.h	2003-02-26 16:37:59.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.h	2003-02-26 18:14:44.000000000 +0100
@@ -23,7 +23,9 @@
 	struct work_struct tq_task;
 	struct timer_list poll_timer;
 
+	struct pcmcia_socket p_sock;
 	struct pcmcia_socket_class_data cls_d;
+
 	/* A few words of private data for the low-level driver.. */
 	unsigned int private[8];
 } pci_socket_t;
diff -ru linux-original/drivers/pcmcia/tcic.c linux/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2003-02-26 16:37:59.000000000 +0100
+++ linux/drivers/pcmcia/tcic.c	2003-02-26 18:25:10.000000000 +0100
@@ -128,6 +128,7 @@
 
 static int sockets;
 static socket_info_t socket_table[2];
+static struct pcmcia_socket p_socket[2];
 
 static socket_cap_t tcic_cap = {
 	/* only 16-bit cards, memory windows must be size-aligned */
@@ -378,6 +379,7 @@
 
 static struct pcmcia_socket_class_data tcic_data = {
 	.ops = &tcic_operations,
+	.socket = &p_socket[0],
 };
 
 static struct device_driver tcic_driver = {
@@ -452,8 +454,6 @@
 	sockets++;
     }
 
-    platform_device_register(&tcic_device);
-
     switch (socket_table[0].id) {
     case TCIC_ID_DB86082:
 	printk("DB86082"); break;
@@ -519,6 +519,7 @@
     for (i = 0; i < sockets; i++) {
 	tcic_setw(TCIC_ADDR+2, socket_table[i].psock << TCIC_SS_SHFT);
 	socket_table[i].last_sstat = tcic_getb(TCIC_SSTAT);
+	p_socket[i].owner = THIS_MODULE;
     }
     
     /* jump start interrupt handler, if needed */
@@ -527,6 +528,8 @@
     tcic_data.nsock = sockets;
     tcic_device.dev.class_data = &tcic_data;
 
+    platform_device_register(&tcic_device);
+
     return 0;
     
 } /* init_tcic */
@@ -634,18 +637,18 @@
 
 /*====================================================================*/
 
-static int tcic_register_callback(unsigned int lsock, void (*handler)(void *, unsigned int), void * info)
+static int tcic_register_callback(struct pcmcia_socket *sock, void (*handler)(void *, unsigned int), void * info)
 {
-    socket_table[lsock].handler = handler;
-    socket_table[lsock].info = info;
+    socket_table[sock->no].handler = handler;
+    socket_table[sock->no].info = info;
     return 0;
 } /* tcic_register_callback */
 
 /*====================================================================*/
 
-static int tcic_get_status(unsigned int lsock, u_int *value)
+static int tcic_get_status(struct pcmcia_socket *sock, u_int *value)
 {
-    u_short psock = socket_table[lsock].psock;
+    u_short psock = socket_table[sock->no].psock;
     u_char reg;
 
     tcic_setl(TCIC_ADDR, (psock << TCIC_ADDR_SS_SHFT)
@@ -663,13 +666,13 @@
     reg = tcic_getb(TCIC_PWR);
     if (reg & (TCIC_PWR_VCC(psock)|TCIC_PWR_VPP(psock)))
 	*value |= SS_POWERON;
-    DEBUG(1, "tcic: GetStatus(%d) = %#2.2x\n", lsock, *value);
+    DEBUG(1, "tcic: GetStatus(%d) = %#2.2x\n", sock->no, *value);
     return 0;
 } /* tcic_get_status */
   
 /*====================================================================*/
 
-static int tcic_inquire_socket(unsigned int lsock, socket_cap_t *cap)
+static int tcic_inquire_socket(struct pcmcia_socket *sock, socket_cap_t *cap)
 {
     *cap = tcic_cap;
     return 0;
@@ -677,9 +680,9 @@
 
 /*====================================================================*/
 
-static int tcic_get_socket(unsigned int lsock, socket_state_t *state)
+static int tcic_get_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-    u_short psock = socket_table[lsock].psock;
+    u_short psock = socket_table[sock->no].psock;
     u_char reg;
     u_short scf1, scf2;
     
@@ -723,21 +726,21 @@
     }
 
     DEBUG(1, "tcic: GetSocket(%d) = flags %#3.3x, Vcc %d, Vpp %d, "
-	  "io_irq %d, csc_mask %#2.2x\n", lsock, state->flags,
+	  "io_irq %d, csc_mask %#2.2x\n", sock->no, state->flags,
 	  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
     return 0;
 } /* tcic_get_socket */
 
 /*====================================================================*/
 
-static int tcic_set_socket(unsigned int lsock, socket_state_t *state)
+static int tcic_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
 {
-    u_short psock = socket_table[lsock].psock;
+    u_short psock = socket_table[sock->no].psock;
     u_char reg;
     u_short scf1, scf2;
 
     DEBUG(1, "tcic: SetSocket(%d, flags %#3.3x, Vcc %d, Vpp %d, "
-	  "io_irq %d, csc_mask %#2.2x)\n", lsock, state->flags,
+	  "io_irq %d, csc_mask %#2.2x)\n", sock->no, state->flags,
 	  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
     tcic_setw(TCIC_ADDR+2, (psock << TCIC_SS_SHFT) | TCIC_ADR2_INDREG);
 
@@ -805,9 +808,9 @@
   
 /*====================================================================*/
 
-static int tcic_get_io_map(unsigned int lsock, struct pccard_io_map *io)
+static int tcic_get_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-    u_short psock = socket_table[lsock].psock;
+    u_short psock = socket_table[sock->no].psock;
     u_short base, ioctl;
     u_int addr;
     
@@ -836,21 +839,21 @@
 	break;
     }
     DEBUG(1, "tcic: GetIOMap(%d, %d) = %#2.2x, %d ns, "
-	  "%#4.4x-%#4.4x\n", lsock, io->map, io->flags,
+	  "%#4.4x-%#4.4x\n", sock->no, io->map, io->flags,
 	  io->speed, io->start, io->stop);
     return 0;
 } /* tcic_get_io_map */
 
 /*====================================================================*/
 
-static int tcic_set_io_map(unsigned int lsock, struct pccard_io_map *io)
+static int tcic_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *io)
 {
-    u_short psock = socket_table[lsock].psock;
+    u_short psock = socket_table[sock->no].psock;
     u_int addr;
     u_short base, len, ioctl;
     
     DEBUG(1, "tcic: SetIOMap(%d, %d, %#2.2x, %d ns, "
-	  "%#4.4x-%#4.4x)\n", lsock, io->map, io->flags,
+	  "%#4.4x-%#4.4x)\n", sock->no, io->map, io->flags,
 	  io->speed, io->start, io->stop);
     if ((io->map > 1) || (io->start > 0xffff) || (io->stop > 0xffff) ||
 	(io->stop < io->start)) return -EINVAL;
@@ -880,9 +883,9 @@
 
 /*====================================================================*/
 
-static int tcic_get_mem_map(unsigned int lsock, struct pccard_mem_map *mem)
+static int tcic_get_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-    u_short psock = socket_table[lsock].psock;
+    u_short psock = socket_table[sock->no].psock;
     u_short addr, ctl;
     u_long base, mmap;
     
@@ -918,21 +921,21 @@
     mem->speed = to_ns(ctl & TCIC_MCTL_WSCNT_MASK);
     
     DEBUG(1, "tcic: GetMemMap(%d, %d) = %#2.2x, %d ns, "
-	  "%#5.5lx-%#5.5lx, %#5.5x\n", lsock, mem->map, mem->flags,
+	  "%#5.5lx-%#5.5lx, %#5.5x\n", sock->no, mem->map, mem->flags,
 	  mem->speed, mem->sys_start, mem->sys_stop, mem->card_start);
     return 0;
 } /* tcic_get_mem_map */
 
 /*====================================================================*/
   
-static int tcic_set_mem_map(unsigned int lsock, struct pccard_mem_map *mem)
+static int tcic_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *mem)
 {
-    u_short psock = socket_table[lsock].psock;
+    u_short psock = socket_table[sock->no].psock;
     u_short addr, ctl;
     u_long base, len, mmap;
 
     DEBUG(1, "tcic: SetMemMap(%d, %d, %#2.2x, %d ns, "
-	  "%#5.5lx-%#5.5lx, %#5.5x)\n", lsock, mem->map, mem->flags,
+	  "%#5.5lx-%#5.5lx, %#5.5x)\n", sock->no, mem->map, mem->flags,
 	  mem->speed, mem->sys_start, mem->sys_stop, mem->card_start);
     if ((mem->map > 3) || (mem->card_start > 0x3ffffff) ||
 	(mem->sys_start > 0xffffff) || (mem->sys_stop > 0xffffff) ||
@@ -969,36 +972,35 @@
 
 /*====================================================================*/
 
-static void tcic_proc_setup(unsigned int sock, struct proc_dir_entry *base)
+static void tcic_proc_setup(struct pcmcia_socket *sock, struct proc_dir_entry *base)
 {
 }
 
-static int tcic_init(unsigned int s)
+static int tcic_init(struct pcmcia_socket *sock)
 {
 	int i;
 	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { 0, 0, 0, 0, 0, 0 };
 
 	mem.sys_stop = 0x1000;
-	tcic_set_socket(s, &dead_socket);
+	tcic_set_socket(sock, &dead_socket);
 	for (i = 0; i < 2; i++) {
 		io.map = i;
-		tcic_set_io_map(s, &io);
+		tcic_set_io_map(sock, &io);
 	}
 	for (i = 0; i < 5; i++) {
 		mem.map = i;
-		tcic_set_mem_map(s, &mem);
+		tcic_set_mem_map(sock, &mem);
 	}
 	return 0;
 }
 
-static int tcic_suspend(unsigned int sock)
+static int tcic_suspend(struct pcmcia_socket *sock)
 {
 	return tcic_set_socket(sock, &dead_socket);
 }
 
 static struct pccard_operations tcic_operations = {
-	.owner		   = THIS_MODULE,
 	.init		   = tcic_init,
 	.suspend	   = tcic_suspend,
 	.register_callback = tcic_register_callback,
diff -ru linux-original/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-02-26 18:44:33.000000000 +0100
+++ linux/include/pcmcia/ss.h	2003-02-26 18:43:16.000000000 +0100
@@ -122,37 +122,51 @@
     u_int	start, stop;
 } cb_bridge_map;
 
+struct pcmcia_socket;
+
 /*
  * Socket operations.
  */
 struct pccard_operations {
-	struct module *owner;
-	int (*init)(unsigned int sock);
-	int (*suspend)(unsigned int sock);
-	int (*register_callback)(unsigned int sock, void (*handler)(void *, unsigned int), void * info);
-	int (*inquire_socket)(unsigned int sock, socket_cap_t *cap);
-	int (*get_status)(unsigned int sock, u_int *value);
-	int (*get_socket)(unsigned int sock, socket_state_t *state);
-	int (*set_socket)(unsigned int sock, socket_state_t *state);
-	int (*get_io_map)(unsigned int sock, struct pccard_io_map *io);
-	int (*set_io_map)(unsigned int sock, struct pccard_io_map *io);
-	int (*get_mem_map)(unsigned int sock, struct pccard_mem_map *mem);
-	int (*set_mem_map)(unsigned int sock, struct pccard_mem_map *mem);
-	void (*proc_setup)(unsigned int sock, struct proc_dir_entry *base);
+	int (*init)(struct pcmcia_socket *sock);
+	int (*suspend)(struct pcmcia_socket *sock);
+	int (*register_callback)(struct pcmcia_socket *sock, void (*handler)(void *, unsigned int), void * info);
+	int (*inquire_socket)(struct pcmcia_socket *sock, socket_cap_t *cap);
+	int (*get_status)(struct pcmcia_socket *sock, u_int *value);
+	int (*get_socket)(struct pcmcia_socket *sock, socket_state_t *state);
+	int (*set_socket)(struct pcmcia_socket *sock, socket_state_t *state);
+	int (*get_io_map)(struct pcmcia_socket *sock, struct pccard_io_map *io);
+	int (*set_io_map)(struct pcmcia_socket *sock, struct pccard_io_map *io);
+	int (*get_mem_map)(struct pcmcia_socket *sock, struct pccard_mem_map *mem);
+	int (*set_mem_map)(struct pcmcia_socket *sock, struct pccard_mem_map *mem);
+	void (*proc_setup)(struct pcmcia_socket *sock, struct proc_dir_entry *base);
 };
 
 /*
  *  Calls to set up low-level "Socket Services" drivers
  */
 
+struct pcmcia_socket {
+	/* this needs to be set by the socket driver */
+	struct module	*owner;
+
+	/* optional */
+	void		*driver_data;
+
+	/* this is overwritten by pcmcia_register_socket anyway */
+	struct device	*s_dev;		/* the socket device */
+	unsigned int	no;		/* number of socket (0,1,..,n) 
+					 * within s_dev */
+};
+
 struct pcmcia_socket_class_data {
 	unsigned int nsock;			/* number of sockets */
-	unsigned int sock_offset;		/* socket # (which is
-	 * returned to driver) = sock_offset + (0, 1, .. , (nsock-1) */
 	struct pccard_operations *ops;		/* see above */
-	void *s_info;				/* socket_info_t */
 	unsigned int use_bus_pm;
 	struct intf_data ds_intf;		/* intf data for driver services */
+	struct pcmcia_socket *socket;
+	/* socket_info_t will be killed in favour of pcmcia_socket */
+	void *s_info;				/* socket_info_t */
 };
 
 extern struct device_class pcmcia_socket_class;
