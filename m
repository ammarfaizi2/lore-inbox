Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSLLLYK>; Thu, 12 Dec 2002 06:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSLLLYK>; Thu, 12 Dec 2002 06:24:10 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:29678 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S262464AbSLLLXq>; Thu, 12 Dec 2002 06:23:46 -0500
Subject: Re: 2.4.20-ac2 and i810 drm
From: Arjan van de Ven <arjanv@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <1039681967.1450.0.camel@laptop.fenrus.com>
References: <3457.210.8.93.34.1039665245.squirrel@www.csn.ul.ie> 
	<1039681967.1450.0.camel@laptop.fenrus.com>
Content-Type: multipart/mixed; boundary="=-Y5qVjxCRoRxSf79ZLr6J"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 12:29:58 +0100
Message-Id: <1039692598.1450.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y5qVjxCRoRxSf79ZLr6J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2002-12-12 at 09:32, Arjan van de Ven wrote:
> On Thu, 2002-12-12 at 04:54, Dave Airlie wrote:
> > 
> > I've been running 2.4.20-rc4 up to now with DRM enabled for my i810
> > chipset and XFree86 4.2 from RH 7.3.
> > 
> > When I run my OpenGL application (internal app) under 2.4.20-ac2 with the
> > same .config when I ctrl-c the application the machine hangs hard.
> > 
> > It is the only application running on the X server so the X server
> > restarts when I exit the app.. under 2.4.20-rc4 this works fine...
> 
> I just got an updated source for the i810 DRM and will port it to -ac2;
> lots of i810 bugfixes

eh woops, i830 updates 
patch is attached

--=-Y5qVjxCRoRxSf79ZLr6J
Content-Disposition: attachment; filename=linux-2.4.20-drm43.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=linux-2.4.20-drm43.patch; charset=UTF-8

diff -urN linux-2.4.20/drivers/char/drm.org/drm_dma.h linux-2.4.20/drivers/=
char/drm/drm_dma.h
--- linux-2.4.20/drivers/char/drm.org/drm_dma.h	2002-12-12 12:26:53.0000000=
00 +0100
+++ linux-2.4.20/drivers/char/drm/drm_dma.h	2002-12-12 12:27:37.000000000 +=
0100
@@ -539,6 +539,10 @@
=20
 #if __HAVE_VBL_IRQ
 	init_waitqueue_head(&dev->vbl_queue);
+
+	spin_lock_init( &dev->vbl_lock );
+
+	INIT_LIST_HEAD( &dev->vbl_sigs.head );
 #endif
=20
 				/* Before installing handler */
@@ -609,7 +613,8 @@
 	drm_device_t *dev =3D priv->dev;
 	drm_wait_vblank_t vblwait;
 	struct timeval now;
-	int ret;
+	int ret =3D 0;
+	unsigned int flags;
=20
 	if (!dev->irq)
 		return -EINVAL;
@@ -617,15 +622,45 @@
 	DRM_COPY_FROM_USER_IOCTL( vblwait, (drm_wait_vblank_t *)data,
 				  sizeof(vblwait) );
=20
-	if ( vblwait.type =3D=3D _DRM_VBLANK_RELATIVE ) {
-		vblwait.sequence +=3D atomic_read( &dev->vbl_received );
+	switch ( vblwait.request.type & ~_DRM_VBLANK_FLAGS_MASK ) {
+	case _DRM_VBLANK_RELATIVE:
+		vblwait.request.sequence +=3D atomic_read( &dev->vbl_received );
+	case _DRM_VBLANK_ABSOLUTE:
+		break;
+	default:
+		return -EINVAL;
 	}
=20
-	ret =3D DRM(vblank_wait)( dev, &vblwait.sequence );
+	flags =3D vblwait.request.type & _DRM_VBLANK_FLAGS_MASK;
+=09
+	if ( flags & _DRM_VBLANK_SIGNAL ) {
+		unsigned long irqflags;
+		drm_vbl_sig_t *vbl_sig =3D kmalloc( sizeof( drm_vbl_sig_t ), GFP_KERNEL =
);
+
+		if ( !vbl_sig )
+			return -ENOMEM;
+
+		memset( (void *)vbl_sig, 0, sizeof(*vbl_sig) );
=20
-	do_gettimeofday( &now );
-	vblwait.tval_sec =3D now.tv_sec;
-	vblwait.tval_usec =3D now.tv_usec;
+		vbl_sig->sequence =3D vblwait.request.sequence;
+		vbl_sig->info.si_signo =3D vblwait.request.signal;
+		vbl_sig->task =3D current;
+
+		vblwait.reply.sequence =3D atomic_read( &dev->vbl_received );
+
+		/* Hook signal entry into list */
+		spin_lock_irqsave( &dev->vbl_lock, irqflags );
+
+		list_add_tail( (struct list_head *) vbl_sig, &dev->vbl_sigs.head );
+
+		spin_unlock_irqrestore( &dev->vbl_lock, irqflags );
+	} else {
+		ret =3D DRM(vblank_wait)( dev, &vblwait.request.sequence );
+
+		do_gettimeofday( &now );
+		vblwait.reply.tval_sec =3D now.tv_sec;
+		vblwait.reply.tval_usec =3D now.tv_usec;
+	}
=20
 	DRM_COPY_TO_USER_IOCTL( (drm_wait_vblank_t *)data, vblwait,
 				sizeof(vblwait) );
@@ -633,6 +668,33 @@
 	return ret;
 }
=20
+void DRM(vbl_send_signals)( drm_device_t *dev )
+{
+	struct list_head *entry, *tmp;
+	drm_vbl_sig_t *vbl_sig;
+	unsigned int vbl_seq =3D atomic_read( &dev->vbl_received );
+	unsigned long flags;
+
+	spin_lock_irqsave( &dev->vbl_lock, flags );
+
+	list_for_each_safe( entry, tmp, &dev->vbl_sigs.head ) {
+
+		vbl_sig =3D (drm_vbl_sig_t *) entry;
+
+		if ( ( vbl_seq - vbl_sig->sequence ) <=3D (1<<23) ) {
+
+			vbl_sig->info.si_code =3D atomic_read( &dev->vbl_received );
+			send_sig_info( vbl_sig->info.si_signo, &vbl_sig->info, vbl_sig->task );
+
+			list_del( entry );
+
+			kfree( entry );
+		}
+	}
+
+	spin_unlock_irqrestore( &dev->vbl_lock, flags );
+}
+
 #endif	/* __HAVE_VBL_IRQ */
=20
 #else
diff -urN linux-2.4.20/drivers/char/drm.org/drm_drv.h linux-2.4.20/drivers/=
char/drm/drm_drv.h
--- linux-2.4.20/drivers/char/drm.org/drm_drv.h	2002-12-12 12:26:53.0000000=
00 +0100
+++ linux-2.4.20/drivers/char/drm/drm_drv.h	2002-12-12 12:27:37.000000000 +=
0100
@@ -765,8 +765,8 @@
 	 * Begin inline drm_release
 	 */
=20
-	DRM_DEBUG( "pid =3D %d, device =3D 0x%x, open_count =3D %d\n",
-		   current->pid, dev->device, dev->open_count );
+	DRM_DEBUG( "pid =3D %d, device =3D 0x%lx, open_count =3D %d\n",
+		   current->pid, (long)dev->device, dev->open_count );
=20
 	if ( dev->lock.hw_lock &&
 	     _DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock) &&
@@ -891,8 +891,9 @@
 	atomic_inc( &dev->counts[_DRM_STAT_IOCTLS] );
 	++priv->ioctl_count;
=20
-	DRM_DEBUG( "pid=3D%d, cmd=3D0x%02x, nr=3D0x%02x, dev 0x%x, auth=3D%d\n",
-		   current->pid, cmd, nr, dev->device, priv->authenticated );
+	DRM_DEBUG( "pid=3D%d, cmd=3D0x%02x, nr=3D0x%02x, dev 0x%lx, auth=3D%d\n",
+		   current->pid, cmd, nr, (long)dev->device,=20
+		   priv->authenticated );
=20
 	if ( nr >=3D DRIVER_IOCTL_COUNT ) {
 		retcode =3D -EINVAL;
diff -urN linux-2.4.20/drivers/char/drm.org/drm_fops.h linux-2.4.20/drivers=
/char/drm/drm_fops.h
--- linux-2.4.20/drivers/char/drm.org/drm_fops.h	2002-12-12 12:26:53.000000=
000 +0100
+++ linux-2.4.20/drivers/char/drm/drm_fops.h	2002-12-12 12:27:37.000000000 =
+0100
@@ -94,8 +94,8 @@
 	drm_file_t    *priv   =3D filp->private_data;
 	drm_device_t  *dev    =3D priv->dev;
=20
-	DRM_DEBUG("pid =3D %d, device =3D 0x%x, open_count =3D %d\n",
-		  current->pid, dev->device, dev->open_count);
+	DRM_DEBUG("pid =3D %d, device =3D 0x%lx, open_count =3D %d\n",
+		  current->pid, (long)dev->device, dev->open_count);
 	return 0;
 }
=20
@@ -105,7 +105,7 @@
 	drm_device_t  *dev    =3D priv->dev;
 	int	      retcode;
=20
-	DRM_DEBUG("fd =3D %d, device =3D 0x%x\n", fd, dev->device);
+	DRM_DEBUG("fd =3D %d, device =3D 0x%lx\n", fd, (long)dev->device);
 	retcode =3D fasync_helper(fd, filp, on, &dev->buf_async);
 	if (retcode < 0) return retcode;
 	return 0;
diff -urN linux-2.4.20/drivers/char/drm.org/drm.h linux-2.4.20/drivers/char=
/drm/drm.h
--- linux-2.4.20/drivers/char/drm.org/drm.h	2002-12-12 12:26:53.000000000 +=
0100
+++ linux-2.4.20/drivers/char/drm/drm.h	2002-12-12 12:27:37.000000000 +0100
@@ -354,17 +354,30 @@
 } drm_irq_busid_t;
=20
 typedef enum {
-    _DRM_VBLANK_ABSOLUTE =3D 0x0,	/* Wait for specific vblank sequence num=
ber */
-    _DRM_VBLANK_RELATIVE =3D 0x1	/* Wait for given number of vblanks */
+    _DRM_VBLANK_ABSOLUTE =3D 0x0,		/* Wait for specific vblank sequence nu=
mber */
+    _DRM_VBLANK_RELATIVE =3D 0x1,		/* Wait for given number of vblanks */
+    _DRM_VBLANK_SIGNAL   =3D 0x80000000	/* Send signal instead of blocking=
 */
 } drm_vblank_seq_type_t;
=20
-typedef struct drm_radeon_vbl_wait {
+#define _DRM_VBLANK_FLAGS_MASK _DRM_VBLANK_SIGNAL
+
+struct drm_wait_vblank_request {
+	drm_vblank_seq_type_t type;
+	unsigned int sequence;
+	unsigned long signal;
+};
+
+struct drm_wait_vblank_reply {
 	drm_vblank_seq_type_t type;
 	unsigned int sequence;
 	long tval_sec;
 	long tval_usec;
-} drm_wait_vblank_t;
+};
=20
+typedef union drm_wait_vblank {
+	struct drm_wait_vblank_request request;
+	struct drm_wait_vblank_reply reply;
+} drm_wait_vblank_t;
=20
 typedef struct drm_agp_mode {
 	unsigned long mode;
diff -urN linux-2.4.20/drivers/char/drm.org/drm_ioctl.h linux-2.4.20/driver=
s/char/drm/drm_ioctl.h
--- linux-2.4.20/drivers/char/drm.org/drm_ioctl.h	2002-12-12 12:26:53.00000=
0000 +0100
+++ linux-2.4.20/drivers/char/drm/drm_ioctl.h	2002-12-12 12:27:37.000000000=
 +0100
@@ -111,7 +111,7 @@
=20
 	do {
 		struct pci_dev *pci_dev;
-                int b, d, f;
+                int domain, b, d, f;
                 char *p;
 =20
                 for(p =3D dev->unique; p && *p && *p !=3D ':'; p++);
@@ -123,6 +123,27 @@
                 f =3D (int)simple_strtoul(p+1, &p, 10);
                 if (*p) break;
 =20
+		domain =3D b >> 8;
+		b &=3D 0xff;
+
+#ifdef __alpha__
+		/*
+		 * Find the hose the device is on (the domain number is the
+		 * hose index) and offset the bus by the root bus of that
+		 * hose.
+		 */
+                for(pci_dev =3D pci_find_device(PCI_ANY_ID,PCI_ANY_ID,NULL=
);
+                    pci_dev;
+                    pci_dev =3D pci_find_device(PCI_ANY_ID,PCI_ANY_ID,pci_=
dev)) {
+			struct pci_controller *hose =3D pci_dev->sysdata;
+		=09
+			if (hose->index =3D=3D domain) {
+				b +=3D hose->bus->number;
+				break;
+			}
+		}
+#endif
+
                 pci_dev =3D pci_find_slot(b, PCI_DEVFN(d,f));
                 if (pci_dev) {
 			dev->pdev =3D pci_dev;
diff -urN linux-2.4.20/drivers/char/drm.org/drmP.h linux-2.4.20/drivers/cha=
r/drm/drmP.h
--- linux-2.4.20/drivers/char/drm.org/drmP.h	2002-12-12 12:26:53.000000000 =
+0100
+++ linux-2.4.20/drivers/char/drm/drmP.h	2002-12-12 12:27:37.000000000 +010=
0
@@ -72,10 +72,7 @@
 #include <asm/pgalloc.h>
 #include "drm.h"
=20
-/* page_to_bus for earlier kernels, not optimal in all cases */
-#ifndef page_to_bus
-#define page_to_bus(page)	((unsigned int)(virt_to_bus(page_address(page)))=
)
-#endif
+#include "drm_os_linux.h"
=20
 /* DRM template customization defaults
  */
@@ -210,6 +207,7 @@
 				 (unsigned long)(n),sizeof(*(ptr))))
 #endif /* i386 & alpha */
 #endif
+#define __REALLY_HAVE_SG	(__HAVE_SG)
=20
 /* Begin the DRM...
  */
@@ -617,6 +615,17 @@
 	drm_map_t		*map;
 } drm_map_list_t;
=20
+#if __HAVE_VBL_IRQ
+
+typedef struct drm_vbl_sig {
+	struct list_head	head;
+	unsigned int		sequence;
+	struct siginfo		info;
+	struct task_struct	*task;
+} drm_vbl_sig_t;
+
+#endif
+
 typedef struct drm_device {
 	const char	  *name;	/* Simple driver name		   */
 	char		  *unique;	/* Unique identifier: e.g., busid  */
@@ -679,6 +688,8 @@
 #if __HAVE_VBL_IRQ
    	wait_queue_head_t vbl_queue;
    	atomic_t          vbl_received;
+	spinlock_t        vbl_lock;
+	drm_vbl_sig_t     vbl_sigs;
 #endif
 	cycles_t	  ctx_start;
 	cycles_t	  lck_start;
@@ -915,6 +926,7 @@
 extern int           DRM(wait_vblank)(struct inode *inode, struct file *fi=
lp,
 				      unsigned int cmd, unsigned long arg);
 extern int           DRM(vblank_wait)(drm_device_t *dev, unsigned int *vbl=
_seq);
+extern void          DRM(vbl_send_signals)( drm_device_t *dev );
 #endif
 #if __HAVE_DMA_IRQ_BH
 extern void          DRM(dma_immediate_bh)( void *dev );
diff -urN linux-2.4.20/drivers/char/drm.org/drm_proc.h linux-2.4.20/drivers=
/char/drm/drm_proc.h
--- linux-2.4.20/drivers/char/drm.org/drm_proc.h	2002-11-29 00:53:12.000000=
000 +0100
+++ linux-2.4.20/drivers/char/drm/drm_proc.h	2002-12-12 12:27:37.000000000 =
+0100
@@ -147,10 +147,10 @@
 	*eof   =3D 0;
=20
 	if (dev->unique) {
-		DRM_PROC_PRINT("%s 0x%x %s\n",
-			       dev->name, dev->device, dev->unique);
+		DRM_PROC_PRINT("%s 0x%lx %s\n",
+			       dev->name, (long)dev->device, dev->unique);
 	} else {
-		DRM_PROC_PRINT("%s 0x%x\n", dev->name, dev->device);
+		DRM_PROC_PRINT("%s 0x%lx\n", dev->name, (long)dev->device);
 	}
=20
 	if (len > request + offset) return request;
diff -urN linux-2.4.20/drivers/char/drm.org/gamma_dma.c linux-2.4.20/driver=
s/char/drm/gamma_dma.c
--- linux-2.4.20/drivers/char/drm.org/gamma_dma.c	2002-12-12 12:26:53.00000=
0000 +0100
+++ linux-2.4.20/drivers/char/drm/gamma_dma.c	2002-12-12 12:27:37.000000000=
 +0100
@@ -521,11 +521,11 @@
 			}
 		}
 		if (retcode) {
-			DRM_ERROR("ctx%d w%d p%d c%d i%d l%d %d/%d\n",
+			DRM_ERROR("ctx%d w%d p%d c%ld i%d l%d %d/%d\n",
 				  d->context,
 				  last_buf->waiting,
 				  last_buf->pending,
-				  DRM_WAITCOUNT(dev, d->context),
+				  (long)DRM_WAITCOUNT(dev, d->context),
 				  last_buf->idx,
 				  last_buf->list,
 				  last_buf->pid,
@@ -591,7 +591,7 @@
 	drm_buf_t	    *buf;
 	int i;
 	struct list_head    *list;
-	unsigned int	    *pgt;
+	unsigned long	    *pgt;
=20
 	DRM_DEBUG( "%s\n", __FUNCTION__ );
=20
diff -urN linux-2.4.20/drivers/char/drm.org/i830_dma.c linux-2.4.20/drivers=
/char/drm/i830_dma.c
--- linux-2.4.20/drivers/char/drm.org/i830_dma.c	2002-12-12 12:26:53.000000=
000 +0100
+++ linux-2.4.20/drivers/char/drm/i830_dma.c	2002-12-12 12:27:37.000000000 =
+0100
@@ -38,6 +38,7 @@
 #include "i830_drm.h"
 #include "i830_drv.h"
 #include <linux/interrupt.h>	/* For task queue support */
+#include <linux/pagemap.h>     /* For FASTCALL on unlock_page() */
 #include <linux/delay.h>
=20
 #define DO_MUNMAP(m, a, l)	do_munmap(m, a, l, 1)
@@ -49,7 +50,6 @@
 #define I830_BUF_UNMAPPED 0
 #define I830_BUF_MAPPED   1
=20
-#define RING_LOCALS	unsigned int outring, ringmask; volatile char *virt;
=20
=20
=20
@@ -63,33 +63,6 @@
=20
=20
=20
-#define I830_VERBOSE 0
-
-#define BEGIN_LP_RING(n) do {				\
-	if (I830_VERBOSE)				\
-		printk("BEGIN_LP_RING(%d) in %s\n",	\
-			  n, __FUNCTION__);		\
-	if (dev_priv->ring.space < n*4) 		\
-		i830_wait_ring(dev, n*4);		\
-	dev_priv->ring.space -=3D n*4;			\
-	outring =3D dev_priv->ring.tail;			\
-	ringmask =3D dev_priv->ring.tail_mask;		\
-	virt =3D dev_priv->ring.virtual_start;		\
-} while (0)
-
-#define ADVANCE_LP_RING() do {					\
-	if (I830_VERBOSE) printk("ADVANCE_LP_RING %x\n", outring);	\
-	dev_priv->ring.tail =3D outring;				\
-	I830_WRITE(LP_RING + RING_TAIL, outring);		\
-} while(0)
-
-#define OUT_RING(n) do {						\
-	if (I830_VERBOSE) printk("   OUT_RING %x\n", (int)(n));	\
-	*(volatile unsigned int *)(virt + outring) =3D n;			\
-	outring +=3D 4;							\
-	outring &=3D ringmask;						\
-} while (0)
-
 static inline void i830_print_status_page(drm_device_t *dev)
 {
    	drm_device_dma_t *dma =3D dev->dma;
@@ -248,7 +221,7 @@
 	buf =3D i830_freelist_get(dev);
 	if (!buf) {
 		retcode =3D -ENOMEM;
-	   	DRM_ERROR("retcode=3D%d\n", retcode);
+	   	DRM_DEBUG("retcode=3D%d\n", retcode);
 		return retcode;
 	}
   =20
@@ -282,12 +255,21 @@
 					 dev_priv->ring.Size);
 		}
 	   	if(dev_priv->hw_status_page !=3D 0UL) {
-		   	pci_free_consistent(dev->pdev, PAGE_SIZE,
+			pci_free_consistent(dev->pdev, PAGE_SIZE,
 					    (void *)dev_priv->hw_status_page,
 					    dev_priv->dma_status_page);
 		   	/* Need to rewrite hardware status page */
 		   	I830_WRITE(0x02080, 0x1ffff000);
 		}
+
+		/* Disable interrupts here because after dev_private
+		 * is freed, it's too late.
+		 */
+		if (dev->irq) {
+			I830_WRITE16( I830REG_INT_MASK_R, 0xffff );
+			I830_WRITE16( I830REG_INT_ENABLE_R, 0x0 );
+		}
+
 	   	DRM(free)(dev->dev_private, sizeof(drm_i830_private_t),=20
 			 DRM_MEM_DRIVER);
 	   	dev->dev_private =3D NULL;
@@ -301,7 +283,7 @@
    	return 0;
 }
=20
-static int i830_wait_ring(drm_device_t *dev, int n)
+int i830_wait_ring(drm_device_t *dev, int n, const char *caller)
 {
    	drm_i830_private_t *dev_priv =3D dev->dev_private;
    	drm_i830_ring_buffer_t *ring =3D &(dev_priv->ring);
@@ -327,6 +309,7 @@
 		   	goto out_wait_ring;
 		}
 		udelay(1);
+		dev_priv->sarea_priv->perf_boxes |=3D I830_BOX_WAIT;
 	}
=20
 out_wait_ring:  =20
@@ -342,6 +325,9 @@
      	ring->tail =3D I830_READ(LP_RING + RING_TAIL) & TAIL_ADDR;
      	ring->space =3D ring->head - (ring->tail+8);
      	if (ring->space < 0) ring->space +=3D ring->Size;
+
+	if (ring->head =3D=3D ring->tail)
+		dev_priv->sarea_priv->perf_boxes |=3D I830_BOX_RING_EMPTY;
 }
=20
 static int i830_freelist_init(drm_device_t *dev, drm_i830_private_t *dev_p=
riv)
@@ -456,6 +442,8 @@
=20
 	dev_priv->back_pitch =3D init->back_pitch;
 	dev_priv->depth_pitch =3D init->depth_pitch;
+	dev_priv->do_boxes =3D 0;
+	dev_priv->use_mi_batchbuffer_start =3D 0;
=20
    	/* Program Hardware Status Page */
    	dev_priv->hw_status_page =3D
@@ -531,11 +519,7 @@
 	unsigned int tmp;
 	RING_LOCALS;
=20
-	BEGIN_LP_RING( I830_CTX_SETUP_SIZE + 2 );
-
-	OUT_RING( GFX_OP_STIPPLE );
-	OUT_RING( 0 );
-
+	BEGIN_LP_RING( I830_CTX_SETUP_SIZE + 4 );
=20
 	for ( i =3D 0 ; i < I830_CTXREG_BLENDCOLR0 ; i++ ) {
 		tmp =3D code[i];
@@ -573,38 +557,44 @@
 	ADVANCE_LP_RING();
 }
=20
-static void i830EmitTexVerified( drm_device_t *dev,=20
-				 volatile unsigned int *code )=20
+static void i830EmitTexVerified( drm_device_t *dev, unsigned int *code )=20
 {
    	drm_i830_private_t *dev_priv =3D dev->dev_private;
 	int i, j =3D 0;
 	unsigned int tmp;
 	RING_LOCALS;
=20
-	BEGIN_LP_RING( I830_TEX_SETUP_SIZE );
-
-	OUT_RING( GFX_OP_MAP_INFO );
-	OUT_RING( code[I830_TEXREG_MI1] );
-	OUT_RING( code[I830_TEXREG_MI2] );
-	OUT_RING( code[I830_TEXREG_MI3] );
-	OUT_RING( code[I830_TEXREG_MI4] );
-	OUT_RING( code[I830_TEXREG_MI5] );
-
-	for ( i =3D 6 ; i < I830_TEX_SETUP_SIZE ; i++ ) {
-		tmp =3D code[i];
-		OUT_RING( tmp );=20
-		j++;
-	}=20
+	if (code[I830_TEXREG_MI0] =3D=3D GFX_OP_MAP_INFO ||
+	    (code[I830_TEXREG_MI0] & ~(0xf*LOAD_TEXTURE_MAP0)) =3D=3D=20
+	    (STATE3D_LOAD_STATE_IMMEDIATE_2|4)) {
+
+		BEGIN_LP_RING( I830_TEX_SETUP_SIZE );
+
+		OUT_RING( code[I830_TEXREG_MI0] ); /* TM0LI */
+		OUT_RING( code[I830_TEXREG_MI1] ); /* TM0S0 */
+		OUT_RING( code[I830_TEXREG_MI2] ); /* TM0S1 */
+		OUT_RING( code[I830_TEXREG_MI3] ); /* TM0S2 */
+		OUT_RING( code[I830_TEXREG_MI4] ); /* TM0S3 */
+		OUT_RING( code[I830_TEXREG_MI5] ); /* TM0S4 */
+	=09
+		for ( i =3D 6 ; i < I830_TEX_SETUP_SIZE ; i++ ) {
+			tmp =3D code[i];
+			OUT_RING( tmp );=20
+			j++;
+		}=20
=20
-	if (j & 1)=20
-		OUT_RING( 0 );=20
+		if (j & 1)=20
+			OUT_RING( 0 );=20
=20
-	ADVANCE_LP_RING();
+		ADVANCE_LP_RING();
+	}
+	else
+		printk("rejected packet %x\n", code[0]);
 }
=20
 static void i830EmitTexBlendVerified( drm_device_t *dev,=20
-				     volatile unsigned int *code,
-				     volatile unsigned int num)
+				      unsigned int *code,
+				      unsigned int num)
 {
    	drm_i830_private_t *dev_priv =3D dev->dev_private;
 	int i, j =3D 0;
@@ -614,7 +604,7 @@
 	if (!num)
 		return;
=20
-	BEGIN_LP_RING( num );
+	BEGIN_LP_RING( num + 1 );
=20
 	for ( i =3D 0 ; i < num ; i++ ) {
 		tmp =3D code[i];
@@ -637,6 +627,8 @@
 	int i;
 	RING_LOCALS;
=20
+	return; /* Is this right ? -- Arjan */
+
 	BEGIN_LP_RING( 258 );
=20
 	if(is_shared =3D=3D 1) {
@@ -650,42 +642,41 @@
 		OUT_RING(palette[i]);
 	}
 	OUT_RING(0);
+	/* KW:  WHERE IS THE ADVANCE_LP_RING?  This is effectively a noop!=20
+	 */
 }
=20
 /* Need to do some additional checking when setting the dest buffer.
  */
 static void i830EmitDestVerified( drm_device_t *dev,=20
-				  volatile unsigned int *code )=20
+				  unsigned int *code )=20
 {=09
    	drm_i830_private_t *dev_priv =3D dev->dev_private;
 	unsigned int tmp;
 	RING_LOCALS;
=20
-	BEGIN_LP_RING( I830_DEST_SETUP_SIZE + 6 );
+	BEGIN_LP_RING( I830_DEST_SETUP_SIZE + 10 );
+
=20
 	tmp =3D code[I830_DESTREG_CBUFADDR];
-	if (tmp =3D=3D dev_priv->front_di1) {
-		/* Don't use fence when front buffer rendering */
-		OUT_RING( CMD_OP_DESTBUFFER_INFO );
-		OUT_RING( BUF_3D_ID_COLOR_BACK |=20
-			  BUF_3D_PITCH(dev_priv->back_pitch * dev_priv->cpp) );
-		OUT_RING( tmp );
+	if (tmp =3D=3D dev_priv->front_di1 || tmp =3D=3D dev_priv->back_di1) {
+		if (((int)outring) & 8) {
+			OUT_RING(0);
+			OUT_RING(0);
+		}
=20
 		OUT_RING( CMD_OP_DESTBUFFER_INFO );
-		OUT_RING( BUF_3D_ID_DEPTH |
-			  BUF_3D_PITCH(dev_priv->depth_pitch * dev_priv->cpp));
-		OUT_RING( dev_priv->zi1 );
-	} else if(tmp =3D=3D dev_priv->back_di1) {
-		OUT_RING( CMD_OP_DESTBUFFER_INFO );
 		OUT_RING( BUF_3D_ID_COLOR_BACK |=20
 			  BUF_3D_PITCH(dev_priv->back_pitch * dev_priv->cpp) |
 			  BUF_3D_USE_FENCE);
 		OUT_RING( tmp );
+		OUT_RING( 0 );
=20
 		OUT_RING( CMD_OP_DESTBUFFER_INFO );
 		OUT_RING( BUF_3D_ID_DEPTH | BUF_3D_USE_FENCE |=20
 			  BUF_3D_PITCH(dev_priv->depth_pitch * dev_priv->cpp));
 		OUT_RING( dev_priv->zi1 );
+		OUT_RING( 0 );
 	} else {
 		DRM_ERROR("bad di1 %x (allow %x or %x)\n",
 			  tmp, dev_priv->front_di1, dev_priv->back_di1);
@@ -713,21 +704,35 @@
 		OUT_RING( 0 );
 	}
=20
-	OUT_RING( code[I830_DESTREG_SENABLE] );
-
 	OUT_RING( GFX_OP_SCISSOR_RECT );
 	OUT_RING( code[I830_DESTREG_SR1] );
 	OUT_RING( code[I830_DESTREG_SR2] );
+	OUT_RING( 0 );
=20
 	ADVANCE_LP_RING();
 }
=20
+static void i830EmitStippleVerified( drm_device_t *dev,=20
+				     unsigned int *code )=20
+{
+   	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	RING_LOCALS;
+
+	BEGIN_LP_RING( 2 );
+	OUT_RING( GFX_OP_STIPPLE );
+	OUT_RING( code[1] );
+	ADVANCE_LP_RING();=09
+}
+
+
 static void i830EmitState( drm_device_t *dev )
 {
    	drm_i830_private_t *dev_priv =3D dev->dev_private;
       	drm_i830_sarea_t *sarea_priv =3D dev_priv->sarea_priv;
 	unsigned int dirty =3D sarea_priv->dirty;
=20
+	DRM_DEBUG("%s %x\n", __FUNCTION__, dirty);
+
 	if (dirty & I830_UPLOAD_BUFFERS) {
 		i830EmitDestVerified( dev, sarea_priv->BufferState );
 		sarea_priv->dirty &=3D ~I830_UPLOAD_BUFFERS;
@@ -761,17 +766,154 @@
 	}
=20
 	if (dirty & I830_UPLOAD_TEX_PALETTE_SHARED) {
-	   i830EmitTexPalette(dev, sarea_priv->Palette[0], 0, 1);
+		i830EmitTexPalette(dev, sarea_priv->Palette[0], 0, 1);
+	} else {
+		if (dirty & I830_UPLOAD_TEX_PALETTE_N(0)) {
+			i830EmitTexPalette(dev, sarea_priv->Palette[0], 0, 0);
+			sarea_priv->dirty &=3D ~I830_UPLOAD_TEX_PALETTE_N(0);
+		}
+		if (dirty & I830_UPLOAD_TEX_PALETTE_N(1)) {
+			i830EmitTexPalette(dev, sarea_priv->Palette[1], 1, 0);
+			sarea_priv->dirty &=3D ~I830_UPLOAD_TEX_PALETTE_N(1);
+		}
+
+		/* 1.3:
+		 */
+#if 0
+		if (dirty & I830_UPLOAD_TEX_PALETTE_N(2)) {
+			i830EmitTexPalette(dev, sarea_priv->Palette2[0], 0, 0);
+			sarea_priv->dirty &=3D ~I830_UPLOAD_TEX_PALETTE_N(2);
+		}
+		if (dirty & I830_UPLOAD_TEX_PALETTE_N(3)) {
+			i830EmitTexPalette(dev, sarea_priv->Palette2[1], 1, 0);
+			sarea_priv->dirty &=3D ~I830_UPLOAD_TEX_PALETTE_N(2);
+		}
+#endif
+	}
+
+	/* 1.3:
+	 */
+	if (dirty & I830_UPLOAD_STIPPLE) {
+		i830EmitStippleVerified( dev,=20
+					 sarea_priv->StippleState);
+		sarea_priv->dirty &=3D ~I830_UPLOAD_STIPPLE;
+	}
+
+	if (dirty & I830_UPLOAD_TEX2) {
+		i830EmitTexVerified( dev, sarea_priv->TexState2 );
+		sarea_priv->dirty &=3D ~I830_UPLOAD_TEX2;
+	}
+
+	if (dirty & I830_UPLOAD_TEX3) {
+		i830EmitTexVerified( dev, sarea_priv->TexState3 );
+		sarea_priv->dirty &=3D ~I830_UPLOAD_TEX3;
+	}
+
+
+	if (dirty & I830_UPLOAD_TEXBLEND2) {
+		i830EmitTexBlendVerified(=20
+			dev,=20
+			sarea_priv->TexBlendState2,
+			sarea_priv->TexBlendStateWordsUsed2);
+
+		sarea_priv->dirty &=3D ~I830_UPLOAD_TEXBLEND2;
+	}
+
+	if (dirty & I830_UPLOAD_TEXBLEND3) {
+		i830EmitTexBlendVerified(=20
+			dev,=20
+			sarea_priv->TexBlendState3,
+			sarea_priv->TexBlendStateWordsUsed3);
+		sarea_priv->dirty &=3D ~I830_UPLOAD_TEXBLEND3;
+	}
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Performance monitoring functions
+ */
+
+static void i830_fill_box( drm_device_t *dev,
+			   int x, int y, int w, int h,
+			   int r, int g, int b )
+{
+   	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	u32 color;
+	unsigned int BR13, CMD;
+	RING_LOCALS;
+
+	BR13 =3D (0xF0 << 16) | (dev_priv->pitch * dev_priv->cpp) | (1<<24);
+	CMD =3D XY_COLOR_BLT_CMD;
+	x +=3D dev_priv->sarea_priv->boxes[0].x1;
+	y +=3D dev_priv->sarea_priv->boxes[0].y1;
+
+	if (dev_priv->cpp =3D=3D 4) {
+		BR13 |=3D (1<<25);
+		CMD |=3D (XY_COLOR_BLT_WRITE_ALPHA | XY_COLOR_BLT_WRITE_RGB);
+		color =3D (((0xff) << 24) | (r << 16) | (g <<  8) | b);=09
 	} else {
-	   if (dirty & I830_UPLOAD_TEX_PALETTE_N(0)) {
-	      i830EmitTexPalette(dev, sarea_priv->Palette[0], 0, 0);
-	      sarea_priv->dirty &=3D ~I830_UPLOAD_TEX_PALETTE_N(0);
-	   }
-	   if (dirty & I830_UPLOAD_TEX_PALETTE_N(1)) {
-	      i830EmitTexPalette(dev, sarea_priv->Palette[1], 1, 0);
-	      sarea_priv->dirty &=3D ~I830_UPLOAD_TEX_PALETTE_N(1);
-	   }
+		color =3D (((r & 0xf8) << 8) |
+			 ((g & 0xfc) << 3) |
+			 ((b & 0xf8) >> 3));
 	}
+
+	BEGIN_LP_RING( 6 );	   =20
+	OUT_RING( CMD );
+	OUT_RING( BR13 );
+	OUT_RING( (y << 16) | x );
+	OUT_RING( ((y+h) << 16) | (x+w) );
+
+ 	if ( dev_priv->current_page =3D=3D 1 ) {=20
+		OUT_RING( dev_priv->front_offset );
+ 	} else {	=20
+		OUT_RING( dev_priv->back_offset );
+ 	}=20
+
+	OUT_RING( color );
+	ADVANCE_LP_RING();
+}
+
+static void i830_cp_performance_boxes( drm_device_t *dev )
+{
+   	drm_i830_private_t *dev_priv =3D dev->dev_private;
+
+	/* Purple box for page flipping
+	 */
+	if ( dev_priv->sarea_priv->perf_boxes & I830_BOX_FLIP )=20
+		i830_fill_box( dev, 4, 4, 8, 8, 255, 0, 255 );
+
+	/* Red box if we have to wait for idle at any point
+	 */
+	if ( dev_priv->sarea_priv->perf_boxes & I830_BOX_WAIT )=20
+		i830_fill_box( dev, 16, 4, 8, 8, 255, 0, 0 );
+
+	/* Blue box: lost context?
+	 */
+	if ( dev_priv->sarea_priv->perf_boxes & I830_BOX_LOST_CONTEXT )=20
+		i830_fill_box( dev, 28, 4, 8, 8, 0, 0, 255 );
+
+	/* Yellow box for texture swaps
+	 */
+	if ( dev_priv->sarea_priv->perf_boxes & I830_BOX_TEXTURE_LOAD )=20
+		i830_fill_box( dev, 40, 4, 8, 8, 255, 255, 0 );
+
+	/* Green box if hardware never idles (as far as we can tell)
+	 */
+	if ( !(dev_priv->sarea_priv->perf_boxes & I830_BOX_RING_EMPTY) )=20
+		i830_fill_box( dev, 64, 4, 8, 8, 0, 255, 0 );
+
+
+	/* Draw bars indicating number of buffers allocated=20
+	 * (not a great measure, easily confused)
+	 */
+	if (dev_priv->dma_used) {
+		int bar =3D dev_priv->dma_used / 10240;
+		if (bar > 100) bar =3D 100;
+		if (bar < 1) bar =3D 1;
+		i830_fill_box( dev, 4, 16, bar, 4, 196, 128, 128 );
+		dev_priv->dma_used =3D 0;
+	}
+
+	dev_priv->sarea_priv->perf_boxes =3D 0;
 }
=20
 static void i830_dma_dispatch_clear( drm_device_t *dev, int flags,=20
@@ -789,6 +931,15 @@
 	unsigned int BR13, CMD, D_CMD;
 	RING_LOCALS;
=20
+
+	if ( dev_priv->current_page =3D=3D 1 ) {
+		unsigned int tmp =3D flags;
+
+		flags &=3D ~(I830_FRONT | I830_BACK);
+		if ( tmp & I830_FRONT ) flags |=3D I830_BACK;
+		if ( tmp & I830_BACK )  flags |=3D I830_FRONT;
+	}
+
   	i830_kernel_lost_context(dev);
=20
 	switch(cpp) {
@@ -868,13 +1019,17 @@
 	drm_clip_rect_t *pbox =3D sarea_priv->boxes;
 	int pitch =3D dev_priv->pitch;
 	int cpp =3D dev_priv->cpp;
-	int ofs =3D dev_priv->back_offset;
 	int i;
 	unsigned int CMD, BR13;
 	RING_LOCALS;
=20
 	DRM_DEBUG("swapbuffers\n");
=20
+  	i830_kernel_lost_context(dev);
+
+	if (dev_priv->do_boxes)
+		i830_cp_performance_boxes( dev );
+
 	switch(cpp) {
 	case 2:=20
 		BR13 =3D (pitch * cpp) | (0xCC << 16) | (1<<24);
@@ -891,7 +1046,6 @@
 		break;
 	}
=20
-  	i830_kernel_lost_context(dev);
=20
       	if (nbox > I830_NR_SAREA_CLIPRECTS)
      		nbox =3D I830_NR_SAREA_CLIPRECTS;
@@ -911,23 +1065,72 @@
 		BEGIN_LP_RING( 8 );
 		OUT_RING( CMD );
 		OUT_RING( BR13 );
+		OUT_RING( (pbox->y1 << 16) | pbox->x1 );
+		OUT_RING( (pbox->y2 << 16) | pbox->x2 );
=20
-		OUT_RING( (pbox->y1 << 16) |
-			  pbox->x1 );
-		OUT_RING( (pbox->y2 << 16) |
-			  pbox->x2 );
-
-		OUT_RING( dev_priv->front_offset );
-		OUT_RING( (pbox->y1 << 16) |
-			  pbox->x1 );
+		if (dev_priv->current_page =3D=3D 0)=20
+			OUT_RING( dev_priv->front_offset );
+		else
+			OUT_RING( dev_priv->back_offset );		=09
=20
+		OUT_RING( (pbox->y1 << 16) | pbox->x1 );
 		OUT_RING( BR13 & 0xffff );
-		OUT_RING( ofs );
+
+		if (dev_priv->current_page =3D=3D 0)=20
+			OUT_RING( dev_priv->back_offset );		=09
+		else
+			OUT_RING( dev_priv->front_offset );
=20
 		ADVANCE_LP_RING();
 	}
 }
=20
+static void i830_dma_dispatch_flip( drm_device_t *dev )
+{
+   	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	RING_LOCALS;
+
+	DRM_DEBUG( "%s: page=3D%d pfCurrentPage=3D%d\n",=20
+		   __FUNCTION__,=20
+		   dev_priv->current_page,
+		   dev_priv->sarea_priv->pf_current_page);
+
+  	i830_kernel_lost_context(dev);
+
+	if (dev_priv->do_boxes) {
+		dev_priv->sarea_priv->perf_boxes |=3D I830_BOX_FLIP;
+		i830_cp_performance_boxes( dev );
+	}
+
+
+	BEGIN_LP_RING( 2 );
+    	OUT_RING( INST_PARSER_CLIENT | INST_OP_FLUSH | INST_FLUSH_MAP_CACHE )=
;=20
+	OUT_RING( 0 );
+	ADVANCE_LP_RING();
+
+	BEGIN_LP_RING( 6 );
+	OUT_RING( CMD_OP_DISPLAYBUFFER_INFO | ASYNC_FLIP );=09
+	OUT_RING( 0 );
+	if ( dev_priv->current_page =3D=3D 0 ) {
+		OUT_RING( dev_priv->back_offset );
+		dev_priv->current_page =3D 1;
+	} else {
+		OUT_RING( dev_priv->front_offset );
+		dev_priv->current_page =3D 0;
+	}
+	OUT_RING(0);
+	ADVANCE_LP_RING();
+
+
+	BEGIN_LP_RING( 2 );
+	OUT_RING( MI_WAIT_FOR_EVENT |
+		  MI_WAIT_FOR_PLANE_A_FLIP );
+	OUT_RING( 0 );
+	ADVANCE_LP_RING();
+=09
+
+	dev_priv->sarea_priv->pf_current_page =3D dev_priv->current_page;
+}
=20
 static void i830_dma_dispatch_vertex(drm_device_t *dev,=20
 				     drm_buf_t *buf,
@@ -980,8 +1183,10 @@
 			 sarea_priv->vertex_prim |
 			 ((used/4)-2));
=20
-		vp[used/4] =3D MI_BATCH_BUFFER_END;
-		used +=3D 4;
+		if (dev_priv->use_mi_batchbuffer_start) {
+			vp[used/4] =3D MI_BATCH_BUFFER_END;=20
+			used +=3D 4;=20
+		}
 	=09
 		if (used & 4) {
 			vp[used/4] =3D 0;
@@ -1004,11 +1209,21 @@
 				ADVANCE_LP_RING();
 			}
=20
-			BEGIN_LP_RING(2);
-			OUT_RING( MI_BATCH_BUFFER_START | (2<<6) );
-			OUT_RING( start | MI_BATCH_NON_SECURE );
-			ADVANCE_LP_RING();
-		=09
+			if (dev_priv->use_mi_batchbuffer_start) {
+				BEGIN_LP_RING(2);
+				OUT_RING( MI_BATCH_BUFFER_START | (2<<6) );
+				OUT_RING( start | MI_BATCH_NON_SECURE );
+				ADVANCE_LP_RING();
+			}=20
+			else {
+				BEGIN_LP_RING(4);
+				OUT_RING( MI_BATCH_BUFFER );
+				OUT_RING( start | MI_BATCH_NON_SECURE );
+				OUT_RING( start + used - 4 );
+				OUT_RING( 0 );
+				ADVANCE_LP_RING();
+			}
+
 		} while (++i < nbox);
 	}
=20
@@ -1046,7 +1261,7 @@
       	OUT_RING( 0 );
    	ADVANCE_LP_RING();
=20
-	i830_wait_ring( dev, dev_priv->ring.Size - 8 );
+	i830_wait_ring( dev, dev_priv->ring.Size - 8, __FUNCTION__ );
 }
=20
 static int i830_flush_queue(drm_device_t *dev)
@@ -1063,7 +1278,7 @@
       	OUT_RING( 0 );
       	ADVANCE_LP_RING();
=20
-	i830_wait_ring( dev, dev_priv->ring.Size - 8 );
+	i830_wait_ring( dev, dev_priv->ring.Size - 8, __FUNCTION__ );
=20
    	for (i =3D 0; i < dma->buf_count; i++) {
 	   	drm_buf_t *buf =3D dma->buflist[ i ];
@@ -1203,6 +1418,53 @@
    	return 0;
 }
=20
+
+
+/* Not sure why this isn't set all the time:
+ */=20
+static void i830_do_init_pageflip( drm_device_t *dev )
+{
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+
+	DRM_DEBUG("%s\n", __FUNCTION__);
+	dev_priv->page_flipping =3D 1;
+	dev_priv->current_page =3D 0;
+	dev_priv->sarea_priv->pf_current_page =3D dev_priv->current_page;
+}
+
+int i830_do_cleanup_pageflip( drm_device_t *dev )
+{
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+
+	DRM_DEBUG("%s\n", __FUNCTION__);
+	if (dev_priv->current_page !=3D 0)
+		i830_dma_dispatch_flip( dev );
+
+	dev_priv->page_flipping =3D 0;
+	return 0;
+}
+
+int i830_flip_bufs(struct inode *inode, struct file *filp,
+		   unsigned int cmd, unsigned long arg)
+{
+	drm_file_t *priv =3D filp->private_data;
+	drm_device_t *dev =3D priv->dev;
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+
+	DRM_DEBUG("%s\n", __FUNCTION__);
+
+   	if(!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
+		DRM_ERROR("i830_flip_buf called without lock held\n");
+		return -EINVAL;
+	}
+
+	if (!dev_priv->page_flipping)=20
+		i830_do_init_pageflip( dev );
+
+	i830_dma_dispatch_flip( dev );
+   	return 0;
+}
+
 int i830_getage(struct inode *inode, struct file *filp, unsigned int cmd,
 		unsigned long arg)
 {
@@ -1266,3 +1528,66 @@
 {
 	return 0;
 }
+
+
+
+int i830_getparam( struct inode *inode, struct file *filp, unsigned int cm=
d,
+		      unsigned long arg )
+{
+	drm_file_t	  *priv	    =3D filp->private_data;
+	drm_device_t	  *dev	    =3D priv->dev;
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	drm_i830_getparam_t param;
+	int value;
+
+	if ( !dev_priv ) {
+		DRM_ERROR( "%s called with no initialization\n", __FUNCTION__ );
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&param, (drm_i830_getparam_t *)arg, sizeof(param) ))
+		return -EFAULT;
+
+	switch( param.param ) {
+	case I830_PARAM_IRQ_ACTIVE:
+		value =3D dev->irq ? 1 : 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if ( copy_to_user( param.value, &value, sizeof(int) ) ) {
+		DRM_ERROR( "copy_to_user\n" );
+		return -EFAULT;
+	}
+=09
+	return 0;
+}
+
+
+int i830_setparam( struct inode *inode, struct file *filp, unsigned int cm=
d,
+		   unsigned long arg )
+{
+	drm_file_t	  *priv	    =3D filp->private_data;
+	drm_device_t	  *dev	    =3D priv->dev;
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	drm_i830_setparam_t param;
+
+	if ( !dev_priv ) {
+		DRM_ERROR( "%s called with no initialization\n", __FUNCTION__ );
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&param, (drm_i830_setparam_t *)arg, sizeof(param) ))
+		return -EFAULT;
+
+	switch( param.param ) {
+	case I830_SETPARAM_USE_MI_BATCHBUFFER_START:
+		dev_priv->use_mi_batchbuffer_start =3D param.value;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff -urN linux-2.4.20/drivers/char/drm.org/i830_drm.h linux-2.4.20/drivers=
/char/drm/i830_drm.h
--- linux-2.4.20/drivers/char/drm.org/i830_drm.h	2002-12-12 12:26:53.000000=
000 +0100
+++ linux-2.4.20/drivers/char/drm/i830_drm.h	2002-12-12 12:27:37.000000000 =
+0100
@@ -3,6 +3,9 @@
=20
 /* WARNING: These defines must be the same as what the Xserver uses.
  * if you change them, you must change the defines in the Xserver.
+ *
+ * KW: Actually, you can't ever change them because doing so would
+ * break backwards compatibility.
  */
=20
 #ifndef _I830_DEFINES_
@@ -18,14 +21,12 @@
 #define I830_NR_TEX_REGIONS 64
 #define I830_LOG_MIN_TEX_REGION_SIZE 16
=20
-/* if defining I830_ENABLE_4_TEXTURES, do it in i830_3d_reg.h, too */
-#if !defined(I830_ENABLE_4_TEXTURES)
+/* KW: These aren't correct but someone set them to two and then
+ * released the module.  Now we can't change them as doing so would
+ * break backwards compatibility.
+ */
 #define I830_TEXTURE_COUNT	2
-#define I830_TEXBLEND_COUNT	2	/* always same as TEXTURE_COUNT? */
-#else /* defined(I830_ENABLE_4_TEXTURES) */
-#define I830_TEXTURE_COUNT	4
-#define I830_TEXBLEND_COUNT	4	/* always same as TEXTURE_COUNT? */
-#endif /* I830_ENABLE_4_TEXTURES */
+#define I830_TEXBLEND_COUNT	I830_TEXTURE_COUNT
=20
 #define I830_TEXBLEND_SIZE	12	/* (4 args + op) * 2 + COLOR_FACTOR */
=20
@@ -57,6 +58,7 @@
 #define I830_UPLOAD_TEXBLEND_MASK	0xf00000
 #define I830_UPLOAD_TEX_PALETTE_N(n)    (0x1000000 << (n))
 #define I830_UPLOAD_TEX_PALETTE_SHARED	0x4000000
+#define I830_UPLOAD_STIPPLE         	0x8000000
=20
 /* Indices into buf.Setup where various bits of state are mirrored per
  * context and per buffer.  These can be fired at the card as a unit,
@@ -73,7 +75,6 @@
  */
=20
 #define I830_DESTREG_CBUFADDR 0
-/* Invarient */
 #define I830_DESTREG_DBUFADDR 1
 #define I830_DESTREG_DV0 2
 #define I830_DESTREG_DV1 3
@@ -109,6 +110,13 @@
 #define I830_CTXREG_MCSB1		16
 #define I830_CTX_SETUP_SIZE		17
=20
+/* 1.3: Stipple state
+ */=20
+#define I830_STPREG_ST0 0
+#define I830_STPREG_ST1 1
+#define I830_STP_SETUP_SIZE 2
+
+
 /* Texture state (per tex unit)
  */
=20
@@ -124,6 +132,18 @@
 #define I830_TEXREG_MCS	9	/* GFX_OP_MAP_COORD_SETS */
 #define I830_TEX_SETUP_SIZE 10
=20
+#define I830_TEXREG_TM0LI      0 /* load immediate 2 texture map n */
+#define I830_TEXREG_TM0S0      1
+#define I830_TEXREG_TM0S1      2
+#define I830_TEXREG_TM0S2      3
+#define I830_TEXREG_TM0S3      4
+#define I830_TEXREG_TM0S4      5
+#define I830_TEXREG_NOP0       6       /* noop */
+#define I830_TEXREG_NOP1       7       /* noop */
+#define I830_TEXREG_NOP2       8       /* noop */
+#define __I830_TEXREG_MCS      9       /* GFX_OP_MAP_COORD_SETS -- shared =
*/
+#define __I830_TEX_SETUP_SIZE   10
+
 #define I830_FRONT   0x1
 #define I830_BACK    0x2
 #define I830_DEPTH   0x4
@@ -199,8 +219,35 @@
 	int ctxOwner;		/* last context to upload state */
=20
 	int vertex_prim;
+
+        int pf_enabled;               /* is pageflipping allowed? */
+        int pf_active;              =20
+        int pf_current_page;	    /* which buffer is being displayed? */
+
+        int perf_boxes;             /* performance boxes to be displayed *=
/
+  =20
+        /* Here's the state for texunits 2,3:
+	 */
+	unsigned int TexState2[I830_TEX_SETUP_SIZE];
+	unsigned int TexBlendState2[I830_TEXBLEND_SIZE];
+	unsigned int TexBlendStateWordsUsed2;
+
+	unsigned int TexState3[I830_TEX_SETUP_SIZE];
+	unsigned int TexBlendState3[I830_TEXBLEND_SIZE];
+	unsigned int TexBlendStateWordsUsed3;
+
+	unsigned int StippleState[I830_STP_SETUP_SIZE];
 } drm_i830_sarea_t;
=20
+/* Flags for perf_boxes
+ */
+#define I830_BOX_RING_EMPTY    0x1 /* populated by kernel */
+#define I830_BOX_FLIP          0x2 /* populated by kernel */
+#define I830_BOX_WAIT          0x4 /* populated by kernel & client */
+#define I830_BOX_TEXTURE_LOAD  0x8 /* populated by kernel */
+#define I830_BOX_LOST_CONTEXT  0x10 /* populated by client */
+
+
 /* I830 specific ioctls
  * The device specific ioctl range is 0x40 to 0x79.
  */
@@ -213,6 +260,11 @@
 #define DRM_IOCTL_I830_SWAP		DRM_IO ( 0x46)
 #define DRM_IOCTL_I830_COPY		DRM_IOW( 0x47, drm_i830_copy_t)
 #define DRM_IOCTL_I830_DOCOPY		DRM_IO ( 0x48)
+#define DRM_IOCTL_I830_FLIP		DRM_IO ( 0x49)
+#define DRM_IOCTL_I830_IRQ_EMIT         DRM_IOWR(0x4a, drm_i830_irq_emit_t=
)
+#define DRM_IOCTL_I830_IRQ_WAIT         DRM_IOW( 0x4b, drm_i830_irq_wait_t=
)
+#define DRM_IOCTL_I830_GETPARAM         DRM_IOWR(0x4c, drm_i830_getparam_t=
)
+#define DRM_IOCTL_I830_SETPARAM         DRM_IOWR(0x4d, drm_i830_setparam_t=
)
=20
 typedef struct _drm_i830_clear {
 	int clear_color;
@@ -248,4 +300,36 @@
 	int granted;
 } drm_i830_dma_t;
=20
+
+/* 1.3: Userspace can request & wait on irq's:
+ */
+typedef struct drm_i830_irq_emit {
+	int *irq_seq;
+} drm_i830_irq_emit_t;
+
+typedef struct drm_i830_irq_wait {
+	int irq_seq;
+} drm_i830_irq_wait_t;
+
+
+/* 1.3: New ioctl to query kernel params:
+ */
+#define I830_PARAM_IRQ_ACTIVE            1
+
+typedef struct drm_i830_getparam {
+	int param;
+	int *value;
+} drm_i830_getparam_t;
+
+
+/* 1.3: New ioctl to set kernel params:
+ */
+#define I830_SETPARAM_USE_MI_BATCHBUFFER_START            1
+
+typedef struct drm_i830_setparam {
+	int param;
+	int value;
+} drm_i830_setparam_t;
+
+
 #endif /* _I830_DRM_H_ */
diff -urN linux-2.4.20/drivers/char/drm.org/i830_drv.h linux-2.4.20/drivers=
/char/drm/i830_drv.h
--- linux-2.4.20/drivers/char/drm.org/i830_drv.h	2002-12-12 12:26:53.000000=
000 +0100
+++ linux-2.4.20/drivers/char/drm/i830_drv.h	2002-12-12 12:27:37.000000000 =
+0100
@@ -78,6 +78,19 @@
 	int back_pitch;
 	int depth_pitch;
 	unsigned int cpp;
+
+	int do_boxes;
+	int dma_used;
+
+	int current_page;
+	int page_flipping;
+
+	wait_queue_head_t irq_queue;
+   	atomic_t irq_received;
+   	atomic_t irq_emitted;
+
+	int use_mi_batchbuffer_start;
+
 } drm_i830_private_t;
=20
 				/* i830_dma.c */
@@ -108,6 +121,23 @@
 extern int i830_clear_bufs(struct inode *inode, struct file *filp,
 			  unsigned int cmd, unsigned long arg);
=20
+extern int i830_flip_bufs(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg);
+
+extern int i830_getparam( struct inode *inode, struct file *filp,
+			  unsigned int cmd, unsigned long arg );
+
+extern int i830_setparam( struct inode *inode, struct file *filp,
+			  unsigned int cmd, unsigned long arg );
+
+/* i830_irq.c */
+extern int i830_irq_emit( struct inode *inode, struct file *filp,=20
+			  unsigned int cmd, unsigned long arg );
+extern int i830_irq_wait( struct inode *inode, struct file *filp,
+			  unsigned int cmd, unsigned long arg );
+extern int i830_wait_irq(drm_device_t *dev, int irq_nr);
+extern int i830_emit_irq(drm_device_t *dev);
+
=20
 #define I830_BASE(reg)		((unsigned long) \
 				dev_priv->mmio_map->handle)
@@ -119,12 +149,53 @@
 #define I830_READ16(reg) 	I830_DEREF16(reg)
 #define I830_WRITE16(reg,val)	do { I830_DEREF16(reg) =3D val; } while (0)
=20
+
+
+#define I830_VERBOSE 0
+
+#define RING_LOCALS	unsigned int outring, ringmask, outcount; \
+                        volatile char *virt;
+
+#define BEGIN_LP_RING(n) do {				\
+	if (I830_VERBOSE)				\
+		printk("BEGIN_LP_RING(%d) in %s\n",	\
+			  n, __FUNCTION__);		\
+	if (dev_priv->ring.space < n*4)			\
+		i830_wait_ring(dev, n*4, __FUNCTION__);		\
+	outcount =3D 0;					\
+	outring =3D dev_priv->ring.tail;			\
+	ringmask =3D dev_priv->ring.tail_mask;		\
+	virt =3D dev_priv->ring.virtual_start;		\
+} while (0)
+
+
+#define OUT_RING(n) do {					\
+	if (I830_VERBOSE) printk("   OUT_RING %x\n", (int)(n));	\
+	*(volatile unsigned int *)(virt + outring) =3D n;		\
+        outcount++;						\
+	outring +=3D 4;						\
+	outring &=3D ringmask;					\
+} while (0)
+
+#define ADVANCE_LP_RING() do {						\
+	if (I830_VERBOSE) printk("ADVANCE_LP_RING %x\n", outring);	\
+	dev_priv->ring.tail =3D outring;					\
+	dev_priv->ring.space -=3D outcount * 4;				\
+	I830_WRITE(LP_RING + RING_TAIL, outring);			\
+} while(0)
+
+extern int i830_wait_ring(drm_device_t *dev, int n, const char *caller);
+
+
 #define GFX_OP_USER_INTERRUPT 		((0<<29)|(2<<23))
 #define GFX_OP_BREAKPOINT_INTERRUPT	((0<<29)|(1<<23))
 #define CMD_REPORT_HEAD			(7<<23)
 #define CMD_STORE_DWORD_IDX		((0x21<<23) | 0x1)
 #define CMD_OP_BATCH_BUFFER  ((0x0<<29)|(0x30<<23)|0x1)
=20
+#define STATE3D_LOAD_STATE_IMMEDIATE_2      ((0x3<<29)|(0x1d<<24)|(0x03<<1=
6))
+#define LOAD_TEXTURE_MAP0                   (1<<11)
+
 #define INST_PARSER_CLIENT   0x00000000
 #define INST_OP_FLUSH        0x02000000
 #define INST_FLUSH_MAP_CACHE 0x00000001
@@ -140,6 +211,9 @@
 #define I830REG_INT_MASK_R 	0x020a8
 #define I830REG_INT_ENABLE_R	0x020a0
=20
+#define I830_IRQ_RESERVED ((1<<13)|(3<<2))
+
+
 #define LP_RING     		0x2030
 #define HP_RING     		0x2040
 #define RING_TAIL      		0x00
@@ -182,6 +256,9 @@
=20
 #define CMD_OP_DESTBUFFER_INFO	 ((0x3<<29)|(0x1d<<24)|(0x8e<<16)|1)
=20
+#define CMD_OP_DISPLAYBUFFER_INFO ((0x0<<29)|(0x14<<23)|2)
+#define ASYNC_FLIP                (1<<22)
+
 #define CMD_3D                          (0x3<<29)
 #define STATE3D_CONST_BLEND_COLOR_CMD   (CMD_3D|(0x1d<<24)|(0x88<<16))
 #define STATE3D_MAP_COORD_SETBIND_CMD   (CMD_3D|(0x1d<<24)|(0x02<<16))
@@ -213,6 +290,11 @@
 #define MI_BATCH_BUFFER_END 	(0xA<<23)
 #define MI_BATCH_NON_SECURE	(1)
=20
+#define MI_WAIT_FOR_EVENT       ((0x3<<23))
+#define MI_WAIT_FOR_PLANE_A_FLIP      (1<<2)=20
+#define MI_WAIT_FOR_PLANE_A_SCANLINES (1<<1)=20
+
+#define MI_LOAD_SCAN_LINES_INCL  ((0x12<<23))
=20
 #endif
=20
diff -urN linux-2.4.20/drivers/char/drm.org/i830.h linux-2.4.20/drivers/cha=
r/drm/i830.h
--- linux-2.4.20/drivers/char/drm.org/i830.h	2002-12-12 12:26:53.000000000 =
+0100
+++ linux-2.4.20/drivers/char/drm/i830.h	2002-12-12 12:27:37.000000000 +010=
0
@@ -45,22 +45,37 @@
=20
 #define DRIVER_NAME		"i830"
 #define DRIVER_DESC		"Intel 830M"
-#define DRIVER_DATE		"20020828"
+#define DRIVER_DATE		"20021108"
=20
+/* Interface history:
+ *
+ * 1.1: Original.
+ * 1.2: ?
+ * 1.3: New irq emit/wait ioctls.
+ *      New pageflip ioctl.
+ *      New getparam ioctl.
+ *      State for texunits 3&4 in sarea.
+ *      New (alternative) layout for texture state.
+ */
 #define DRIVER_MAJOR		1
-#define DRIVER_MINOR		2
-#define DRIVER_PATCHLEVEL	1
+#define DRIVER_MINOR		3
+#define DRIVER_PATCHLEVEL	2
=20
 #define DRIVER_IOCTLS							    \
 	[DRM_IOCTL_NR(DRM_IOCTL_I830_INIT)]   =3D { i830_dma_init,    1, 1 }, \
-   	[DRM_IOCTL_NR(DRM_IOCTL_I830_VERTEX)] =3D { i830_dma_vertex,  1, 0 }, =
\
-   	[DRM_IOCTL_NR(DRM_IOCTL_I830_CLEAR)]  =3D { i830_clear_bufs,  1, 0 }, =
\
-      	[DRM_IOCTL_NR(DRM_IOCTL_I830_FLUSH)]  =3D { i830_flush_ioctl, 1, 0 =
}, \
-   	[DRM_IOCTL_NR(DRM_IOCTL_I830_GETAGE)] =3D { i830_getage,      1, 0 }, =
\
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_VERTEX)] =3D { i830_dma_vertex,  1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_CLEAR)]  =3D { i830_clear_bufs,  1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_FLUSH)]  =3D { i830_flush_ioctl, 1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_GETAGE)] =3D { i830_getage,      1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_I830_GETBUF)] =3D { i830_getbuf,      1, 0 }, \
-   	[DRM_IOCTL_NR(DRM_IOCTL_I830_SWAP)]   =3D { i830_swap_bufs,   1, 0 }, =
\
-   	[DRM_IOCTL_NR(DRM_IOCTL_I830_COPY)]   =3D { i830_copybuf,     1, 0 }, =
\
-   	[DRM_IOCTL_NR(DRM_IOCTL_I830_DOCOPY)] =3D { i830_docopy,      1, 0 },
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_SWAP)]   =3D { i830_swap_bufs,   1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_COPY)]   =3D { i830_copybuf,     1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_DOCOPY)] =3D { i830_docopy,      1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_FLIP)]   =3D { i830_flip_bufs,   1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_IRQ_EMIT)] =3D { i830_irq_emit,  1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_IRQ_WAIT)] =3D { i830_irq_wait,  1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_GETPARAM)] =3D { i830_getparam,  1, 0 }, \
+	[DRM_IOCTL_NR(DRM_IOCTL_I830_SETPARAM)] =3D { i830_setparam,  1, 0 }=20
=20
 #define __HAVE_COUNTERS         4
 #define __HAVE_COUNTER6         _DRM_STAT_IRQ
@@ -87,10 +102,49 @@
 	i830_dma_quiescent( dev );					\
 } while (0)
=20
-/* Don't need an irq any more.  The template code will make sure that
- * a noop stub is generated for compatibility.
+
+/* Driver will work either way: IRQ's save cpu time when waiting for
+ * the card, but are subject to subtle interactions between bios,
+ * hardware and the driver.
+ */
+#define USE_IRQS 0
+
+
+#if USE_IRQS
+#define __HAVE_DMA_IRQ		1
+#define __HAVE_SHARED_IRQ	1
+
+#define DRIVER_PREINSTALL() do {			\
+	drm_i830_private_t *dev_priv =3D			\
+		(drm_i830_private_t *)dev->dev_private;	\
+							\
+   	I830_WRITE16( I830REG_HWSTAM, 0xffff );	\
+        I830_WRITE16( I830REG_INT_MASK_R, 0x0 );	\
+      	I830_WRITE16( I830REG_INT_ENABLE_R, 0x0 );	\
+} while (0)
+
+
+#define DRIVER_POSTINSTALL() do {				\
+	drm_i830_private_t *dev_priv =3D				\
+		(drm_i830_private_t *)dev->dev_private;		\
+   	I830_WRITE16( I830REG_INT_ENABLE_R, 0x2 );		\
+   	atomic_set(&dev_priv->irq_received, 0);			\
+   	atomic_set(&dev_priv->irq_emitted, 0);			\
+	init_waitqueue_head(&dev_priv->irq_queue);		\
+} while (0)
+
+
+/* This gets called too late to be useful: dev_priv has already been
+ * freed.
  */
-#define __HAVE_DMA_IRQ		0
+#define DRIVER_UNINSTALL() do {					\
+} while (0)
+
+#else
+#define __HAVE_DMA_IRQ          0
+#endif
+
+
=20
 /* Buffer customization:
  */
diff -urN linux-2.4.20/drivers/char/drm.org/i830_irq.c linux-2.4.20/drivers=
/char/drm/i830_irq.c
--- linux-2.4.20/drivers/char/drm.org/i830_irq.c	1970-01-01 01:00:00.000000=
000 +0100
+++ linux-2.4.20/drivers/char/drm/i830_irq.c	2002-12-12 12:27:37.000000000 =
+0100
@@ -0,0 +1,178 @@
+/* i830_dma.c -- DMA support for the I830 -*- linux-c -*-
+ *
+ * Copyright 2002 Tungsten Graphics, Inc.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *=20
+ * The above copyright notice and this permission notice (including the ne=
xt
+ * paragraph) shall be included in all copies or substantial portions of t=
he
+ * Software.
+ *=20
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * TUNGSTEN GRAPHICS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR O=
THER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Keith Whitwell <keith@tungstengraphics.com>
+ *
+ */
+
+
+#include "i830.h"
+#include "drmP.h"
+#include "drm.h"
+#include "i830_drm.h"
+#include "i830_drv.h"
+#include <linux/interrupt.h>	/* For task queue support */
+#include <linux/delay.h>
+
+
+void DRM(dma_service)(int irq, void *device, struct pt_regs *regs)
+{
+	drm_device_t	 *dev =3D (drm_device_t *)device;
+      	drm_i830_private_t *dev_priv =3D (drm_i830_private_t *)dev->dev_pri=
vate;
+   	u16 temp;
+  =20
+      	temp =3D I830_READ16(I830REG_INT_IDENTITY_R);
+	printk("%s: %x\n", __FUNCTION__, temp);
+=09
+   	if(temp =3D=3D 0)=20
+	   return;
+
+	I830_WRITE16(I830REG_INT_IDENTITY_R, temp);=20
+
+	if (temp & 2) {
+		atomic_inc(&dev_priv->irq_received);
+		wake_up_interruptible(&dev_priv->irq_queue);=20
+	}
+}
+
+
+int i830_emit_irq(drm_device_t *dev)
+{
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	RING_LOCALS;
+
+	DRM_DEBUG("%s\n", __FUNCTION__);
+
+	atomic_inc(&dev_priv->irq_emitted);
+
+   	BEGIN_LP_RING(2);
+      	OUT_RING( 0 );
+      	OUT_RING( GFX_OP_USER_INTERRUPT );
+      	ADVANCE_LP_RING();
+
+	return atomic_read(&dev_priv->irq_emitted);
+}
+
+
+int i830_wait_irq(drm_device_t *dev, int irq_nr)
+{
+  	drm_i830_private_t *dev_priv =3D=20
+	   (drm_i830_private_t *)dev->dev_private;
+	DECLARE_WAITQUEUE(entry, current);
+	unsigned long end =3D jiffies + HZ*3;
+	int ret =3D 0;
+
+	DRM_DEBUG("%s\n", __FUNCTION__);
+
+ 	if (atomic_read(&dev_priv->irq_received) >=3D irq_nr) =20
+ 		return 0;=20
+
+	dev_priv->sarea_priv->perf_boxes |=3D I830_BOX_WAIT;
+
+	add_wait_queue(&dev_priv->irq_queue, &entry);
+
+	for (;;) {
+		current->state =3D TASK_INTERRUPTIBLE;
+	   	if (atomic_read(&dev_priv->irq_received) >=3D irq_nr)=20
+		   break;
+		if (time_after(jiffies, end)) {
+			DRM_ERROR("timeout iir %x imr %x ier %x hwstam %x\n",
+				  I830_READ16( I830REG_INT_IDENTITY_R ),
+				  I830_READ16( I830REG_INT_MASK_R ),
+				  I830_READ16( I830REG_INT_ENABLE_R ),
+				  I830_READ16( I830REG_HWSTAM ));
+
+		   	ret =3D -EBUSY;	/* Lockup?  Missed irq? */
+			break;
+		}
+	      	schedule_timeout(HZ*3);
+	      	if (signal_pending(current)) {
+		   	ret =3D -EINTR;
+			break;
+		}
+	}
+
+	current->state =3D TASK_RUNNING;
+	remove_wait_queue(&dev_priv->irq_queue, &entry);
+	return ret;
+}
+
+
+/* Needs the lock as it touches the ring.
+ */
+int i830_irq_emit( struct inode *inode, struct file *filp, unsigned int cm=
d,
+		   unsigned long arg )
+{
+	drm_file_t	  *priv	    =3D filp->private_data;
+	drm_device_t	  *dev	    =3D priv->dev;
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	drm_i830_irq_emit_t emit;
+	int result;
+
+   	if(!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
+		DRM_ERROR("i830_irq_emit called without lock held\n");
+		return -EINVAL;
+	}
+
+	if ( !dev_priv ) {
+		DRM_ERROR( "%s called with no initialization\n", __FUNCTION__ );
+		return -EINVAL;
+	}
+
+	if (copy_from_user( &emit, (drm_i830_irq_emit_t *)arg, sizeof(emit) ))
+		return -EFAULT;
+
+	result =3D i830_emit_irq( dev );
+
+	if ( copy_to_user( emit.irq_seq, &result, sizeof(int) ) ) {
+		DRM_ERROR( "copy_to_user\n" );
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+
+/* Doesn't need the hardware lock.
+ */
+int i830_irq_wait( struct inode *inode, struct file *filp, unsigned int cm=
d,
+		   unsigned long arg )
+{
+	drm_file_t	  *priv	    =3D filp->private_data;
+	drm_device_t	  *dev	    =3D priv->dev;
+	drm_i830_private_t *dev_priv =3D dev->dev_private;
+	drm_i830_irq_wait_t irqwait;
+
+	if ( !dev_priv ) {
+		DRM_ERROR( "%s called with no initialization\n", __FUNCTION__ );
+		return -EINVAL;
+	}
+
+	if (copy_from_user( &irqwait, (drm_i830_irq_wait_t *)arg,=20
+			    sizeof(irqwait) ))
+		return -EFAULT;
+
+	return i830_wait_irq( dev, irqwait.irq_seq );
+}
+
diff -urN linux-2.4.20/drivers/char/drm.org/Makefile linux-2.4.20/drivers/c=
har/drm/Makefile
--- linux-2.4.20/drivers/char/drm.org/Makefile	2002-12-12 12:26:53.00000000=
0 +0100
+++ linux-2.4.20/drivers/char/drm/Makefile	2002-12-12 12:27:37.000000000 +0=
100
@@ -10,7 +10,7 @@
 r128-objs   :=3D r128_drv.o r128_cce.o r128_state.o
 mga-objs    :=3D mga_drv.o mga_dma.o mga_state.o mga_warp.o
 i810-objs   :=3D i810_drv.o i810_dma.o
-i830-objs   :=3D i830_drv.o i830_dma.o
+i830-objs   :=3D i830_drv.o i830_dma.o i830_irq.o
=20
 radeon-objs :=3D radeon_drv.o radeon_cp.o radeon_state.o radeon_mem.o rade=
on_irq.o
 ffb-objs    :=3D ffb_drv.o ffb_context.o
diff -urN linux-2.4.20/drivers/char/drm.org/r128_drv.h linux-2.4.20/drivers=
/char/drm/r128_drv.h
--- linux-2.4.20/drivers/char/drm.org/r128_drv.h	2002-12-12 12:26:53.000000=
000 +0100
+++ linux-2.4.20/drivers/char/drm/r128_drv.h	2002-12-12 12:27:37.000000000 =
+0100
@@ -438,6 +438,7 @@
 		return -EBUSY;						\
 	}								\
  __ring_space_done: ;							\
+  break;								\
 } while (0)
=20
 #define VB_AGE_TEST_WITH_RETURN( dev_priv )				\
diff -urN linux-2.4.20/drivers/char/drm.org/radeon_irq.c linux-2.4.20/drive=
rs/char/drm/radeon_irq.c
--- linux-2.4.20/drivers/char/drm.org/radeon_irq.c	2002-12-12 12:26:53.0000=
00000 +0100
+++ linux-2.4.20/drivers/char/drm/radeon_irq.c	2002-12-12 12:27:37.00000000=
0 +0100
@@ -71,13 +71,12 @@
 		wake_up_interruptible( &dev_priv->swi_queue );
 	}
=20
-#if __HAVE_VBL_IRQ
 	/* VBLANK interrupt */
 	if (stat & RADEON_CRTC_VBLANK_STAT) {
 		atomic_inc(&dev->vbl_received);
 		wake_up_interruptible(&dev->vbl_queue);
+		DRM(vbl_send_signals)(dev);
 	}
-#endif
=20
 	/* Acknowledge all the bits in GEN_INT_STATUS -- seem to get
 	 * more than we asked for...
@@ -139,7 +138,6 @@
 }
=20
=20
-#if __HAVE_VBL_IRQ
 int DRM(vblank_wait)(drm_device_t *dev, unsigned int *sequence)
 {
   	drm_radeon_private_t *dev_priv =3D=20
@@ -162,13 +160,12 @@
 	 */
 	DRM_WAIT_ON( ret, dev->vbl_queue, 3*HZ,=20
 		     ( ( ( cur_vblank =3D atomic_read(&dev->vbl_received ) )
-			 + ~*sequence + 1 ) <=3D (1<<23) ) );
+			 - ~*sequence + 1 ) <=3D (1<<23) ) );
=20
 	*sequence =3D cur_vblank;
=20
 	return ret;
 }
-#endif
=20
=20
 /* Needs the lock as it touches the ring.

--=-Y5qVjxCRoRxSf79ZLr6J--
