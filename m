Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbTCYT3V>; Tue, 25 Mar 2003 14:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbTCYT2T>; Tue, 25 Mar 2003 14:28:19 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:16561 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263275AbTCYT0t>; Tue, 25 Mar 2003 14:26:49 -0500
Date: Tue, 25 Mar 2003 20:37:28 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia (3/4): convert ds.c's socekt_info_t to struct pcmcia_bus_socket
Message-ID: <20030325193728.GC15319@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename socket_info_t (which is used many, many times differently
within pcmcia) to "struct pcmcia_bus_socket".

Also, a couple of functions in ds.c can be converted to use the "struct
pcmcia_bus_socket" as argument instead of the socket number.

 ds.c |   87 +++++++++++++++++++++++++++++++------------------------------------
 1 files changed, 41 insertions(+), 46 deletions(-)

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-25 20:05:08.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-25 20:06:25.000000000 +0100
@@ -99,18 +99,18 @@
 } user_info_t;
 
 /* Socket state information */
-typedef struct socket_info_t {
-    client_handle_t	handle;
-    int			state;
-    user_info_t		*user;
-    int			req_pending, req_result;
-    wait_queue_head_t	queue, request;
-    struct timer_list	removal;
-    socket_bind_t	*bind;
+struct pcmcia_bus_socket {
+	client_handle_t		handle;
+	int			state;
+	user_info_t		*user;
+	int			req_pending, req_result;
+	wait_queue_head_t	queue, request;
+	struct timer_list	removal;
+	socket_bind_t		*bind;
 	struct device		*socket_dev;
 	struct list_head	socket_list;
 	unsigned int		socket_no; /* deprecated */
-} socket_info_t;
+};
 
 #define SOCKET_PRESENT		0x01
 #define SOCKET_BUSY		0x02
@@ -140,7 +140,7 @@
 /*======================================================================*/
 
 static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
-static socket_info_t * get_socket_info_by_nr(unsigned int nr);
+static struct pcmcia_bus_socket * get_socket_info_by_nr(unsigned int nr);
 
 /**
  * pcmcia_register_driver - register a PCMCIA driver with the bus core
@@ -165,7 +165,7 @@
 void pcmcia_unregister_driver(struct pcmcia_driver *driver)
 {
 	socket_bind_t *b;
-	socket_info_t *bus_sock;
+	struct pcmcia_bus_socket *bus_sock;
 
 	if (driver->use_count > 0) {
 		/* Blank out any left-over device instances */
@@ -189,7 +189,7 @@
 {
     struct pcmcia_driver *driver;
     socket_bind_t *b;
-    socket_info_t *bus_sock;
+    struct pcmcia_bus_socket *bus_sock;
 
     DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
     driver = get_pcmcia_driver(dev_info);
@@ -290,7 +290,7 @@
     user->event[user->event_head] = event;
 }
 
-static void handle_event(socket_info_t *s, event_t event)
+static void handle_event(struct pcmcia_bus_socket *s, event_t event)
 {
     user_info_t *user;
     for (user = s->user; user; user = user->next)
@@ -298,7 +298,7 @@
     wake_up_interruptible(&s->queue);
 }
 
-static int handle_request(socket_info_t *s, event_t event)
+static int handle_request(struct pcmcia_bus_socket *s, event_t event)
 {
     if (s->req_pending != 0)
 	return CS_IN_USE;
@@ -317,7 +317,7 @@
 
 static void handle_removal(u_long sn)
 {
-    socket_info_t *s = get_socket_info_by_nr(sn);
+    struct pcmcia_bus_socket *s = get_socket_info_by_nr(sn);
     handle_event(s, CS_EVENT_CARD_REMOVAL);
     s->state &= ~SOCKET_REMOVAL_PENDING;
 }
@@ -331,13 +331,11 @@
 static int ds_event(event_t event, int priority,
 		    event_callback_args_t *args)
 {
-    socket_info_t *s;
-    int i;
+    struct pcmcia_bus_socket *s;
 
     DEBUG(1, "ds: ds_event(0x%06x, %d, 0x%p)\n",
 	  event, priority, args->client_handle);
     s = args->client_data;
-    i = s->socket_no;
     
     switch (event) {
 	
@@ -374,21 +372,21 @@
     
 ======================================================================*/
 
-static int bind_mtd(int i, mtd_info_t *mtd_info)
+static int bind_mtd(struct pcmcia_bus_socket *bus_sock, mtd_info_t *mtd_info)
 {
     mtd_bind_t bind_req;
     int ret;
 
     bind_req.dev_info = &mtd_info->dev_info;
     bind_req.Attributes = mtd_info->Attributes;
-    bind_req.Socket = i;
+    bind_req.Socket = bus_sock->socket_no;
     bind_req.CardOffset = mtd_info->CardOffset;
     ret = pcmcia_bind_mtd(&bind_req);
     if (ret != CS_SUCCESS) {
 	cs_error(NULL, BindMTD, ret);
 	printk(KERN_NOTICE "ds: unable to bind MTD '%s' to socket %d"
 	       " offset 0x%x\n",
-	       (char *)bind_req.dev_info, i, bind_req.CardOffset);
+	       (char *)bind_req.dev_info, bus_sock->socket_no, bind_req.CardOffset);
 	return -ENODEV;
     }
     return 0;
@@ -403,12 +401,11 @@
     
 ======================================================================*/
 
-static int bind_request(int i, bind_info_t *bind_info)
+static int bind_request(struct pcmcia_bus_socket *s, bind_info_t *bind_info)
 {
     struct pcmcia_driver *driver;
     socket_bind_t *b;
     bind_req_t bind_req;
-    socket_info_t *s = get_socket_info_by_nr(i);
     int ret;
 
     if (!s)
@@ -434,14 +431,14 @@
 	return -EBUSY;
     }
 
-    bind_req.Socket = i;
+    bind_req.Socket = s->socket_no;
     bind_req.Function = bind_info->function;
     bind_req.dev_info = (dev_info_t *) driver->drv.name;
     ret = pcmcia_bind_device(&bind_req);
     if (ret != CS_SUCCESS) {
 	cs_error(NULL, BindDevice, ret);
 	printk(KERN_NOTICE "ds: unable to bind '%s' to socket %d\n",
-	       (char *)dev_info, i);
+	       (char *)dev_info, s->socket_no);
 	return -ENODEV;
     }
 
@@ -473,9 +470,8 @@
 
 /*====================================================================*/
 
-static int get_device_info(int i, bind_info_t *bind_info, int first)
+static int get_device_info(struct pcmcia_bus_socket *s, bind_info_t *bind_info, int first)
 {
-    socket_info_t *s = get_socket_info_by_nr(i);
     socket_bind_t *b;
     dev_node_t *node;
 
@@ -543,9 +539,8 @@
 
 /*====================================================================*/
 
-static int unbind_request(int i, bind_info_t *bind_info)
+static int unbind_request(struct pcmcia_bus_socket *s, bind_info_t *bind_info)
 {
-    socket_info_t *s = get_socket_info_by_nr(i);
     socket_bind_t **b, *c;
 
     DEBUG(2, "unbind_request(%d, '%s')\n", i,
@@ -579,7 +574,7 @@
 static int ds_open(struct inode *inode, struct file *file)
 {
     socket_t i = minor(inode->i_rdev);
-    socket_info_t *s;
+    struct pcmcia_bus_socket *s;
     user_info_t *user;
 
     DEBUG(0, "ds_open(socket %d)\n", i);
@@ -613,7 +608,7 @@
 static int ds_release(struct inode *inode, struct file *file)
 {
     socket_t i = minor(inode->i_rdev);
-    socket_info_t *s;
+    struct pcmcia_bus_socket *s;
     user_info_t *user, **link;
 
     DEBUG(0, "ds_release(socket %d)\n", i);
@@ -647,7 +642,7 @@
 		       size_t count, loff_t *ppos)
 {
     socket_t i = minor(file->f_dentry->d_inode->i_rdev);
-    socket_info_t *s;
+    struct pcmcia_bus_socket *s;
     user_info_t *user;
 
     DEBUG(2, "ds_read(socket %d)\n", i);
@@ -678,7 +673,7 @@
 			size_t count, loff_t *ppos)
 {
     socket_t i = minor(file->f_dentry->d_inode->i_rdev);
-    socket_info_t *s;
+    struct pcmcia_bus_socket *s;
     user_info_t *user;
 
     DEBUG(2, "ds_write(socket %d)\n", i);
@@ -713,7 +708,7 @@
 static u_int ds_poll(struct file *file, poll_table *wait)
 {
     socket_t i = minor(file->f_dentry->d_inode->i_rdev);
-    socket_info_t *s;
+    struct pcmcia_bus_socket *s;
     user_info_t *user;
 
     DEBUG(2, "ds_poll(socket %d)\n", i);
@@ -737,7 +732,7 @@
 		    u_int cmd, u_long arg)
 {
     socket_t i = minor(inode->i_rdev);
-    socket_info_t *s;
+    struct pcmcia_bus_socket *s;
     u_int size;
     int ret, err;
     ds_ioctl_arg_t buf;
@@ -847,20 +842,20 @@
 	break;
     case DS_BIND_REQUEST:
 	if (!capable(CAP_SYS_ADMIN)) return -EPERM;
-	err = bind_request(i, &buf.bind_info);
+	err = bind_request(s, &buf.bind_info);
 	break;
     case DS_GET_DEVICE_INFO:
-	err = get_device_info(i, &buf.bind_info, 1);
+	err = get_device_info(s, &buf.bind_info, 1);
 	break;
     case DS_GET_NEXT_DEVICE:
-	err = get_device_info(i, &buf.bind_info, 0);
+	err = get_device_info(s, &buf.bind_info, 0);
 	break;
     case DS_UNBIND_REQUEST:
-	err = unbind_request(i, &buf.bind_info);
+	err = unbind_request(s, &buf.bind_info);
 	break;
     case DS_BIND_MTD:
 	if (!capable(CAP_SYS_ADMIN)) return -EPERM;
-	err = bind_mtd(i, &buf.mtd_info);
+	err = bind_mtd(s, &buf.mtd_info);
 	break;
     default:
 	err = -EINVAL;
@@ -913,14 +908,14 @@
 {
 	client_reg_t client_reg;
 	bind_req_t bind;
-	socket_info_t *s, *tmp_s;
+	struct pcmcia_bus_socket *s, *tmp_s;
 	int ret;
 	int i;
 
-	s = kmalloc(sizeof(socket_info_t), GFP_KERNEL);
+	s = kmalloc(sizeof(struct pcmcia_bus_socket), GFP_KERNEL);
 	if(!s)
 		return -ENOMEM;
-	memset(s, 0, sizeof(socket_info_t));
+	memset(s, 0, sizeof(struct pcmcia_bus_socket));
     
 	/*
 	 * Ugly. But we want to wait for the socket threads to have started up.
@@ -1014,7 +1009,7 @@
 
 	down_write(&bus_socket_list_rwsem);
 	list_for_each_safe(list_loop, tmp_storage, &bus_socket_list) {
-		socket_info_t *bus_sock = container_of(list_loop, socket_info_t, socket_list);
+		struct pcmcia_bus_socket *bus_sock = container_of(list_loop, struct pcmcia_bus_socket, socket_list);
 		if (bus_sock->socket_dev == dev) {
 			pcmcia_deregister_client(bus_sock->handle);
 			list_del(&bus_sock->socket_list);
@@ -1089,9 +1084,9 @@
 /* helpers for backwards-compatible functions */
 
 
-static socket_info_t * get_socket_info_by_nr(unsigned int nr)
+static struct pcmcia_bus_socket * get_socket_info_by_nr(unsigned int nr)
 {
-	socket_info_t * s;
+	struct pcmcia_bus_socket * s;
 	down_read(&bus_socket_list_rwsem);
 	list_for_each_entry(s, &bus_socket_list, socket_list)
 		if (s->socket_no == nr) {
