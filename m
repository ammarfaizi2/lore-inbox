Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131078AbRAKQJ3>; Thu, 11 Jan 2001 11:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131109AbRAKQJT>; Thu, 11 Jan 2001 11:09:19 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:22256 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131078AbRAKQJG>; Thu, 11 Jan 2001 11:09:06 -0500
Date: Thu, 11 Jan 2001 12:21:39 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] dgrs.c: kmalloc release on failure
Message-ID: <20010111122139.D5473@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jaroslav Kysela <perex@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <01011109382601.29363@depoffice.localdomain> <E14Gj32-0002ND-00@the-village.bc.nu> <20010111110921.F32099@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111110921.F32099@conectiva.com.br>; from acme@conectiva.com.br on Thu, Jan 11, 2001 at 11:09:21AM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.0-ac6/drivers/net/hp100.c	Tue Dec 19 11:25:41 2000
+++ linux-2.4.0-ac6.acme/drivers/net/hp100.c	Thu Jan 11 11:52:34 2001
@@ -45,6 +45,8 @@
 **   along with this program; if not, write to the Free Software
 **   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 **
+** 1.57b -> 1.57c - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+**   - release resources on failure in init_module
 **
 ** 1.57 -> 1.57b - Jean II
 **   - fix spinlocks, SMP is now working !
@@ -3024,7 +3026,25 @@
 MODULE_PARM(hp100_name, "1-5c" __MODULE_STRING(IFNAMSIZ));
 
 /* List of devices */
-static struct net_device *hp100_devlist[5] = { NULL, NULL, NULL, NULL, NULL };
+static struct net_device *hp100_devlist[5];
+
+static void release_dev(int i)
+{
+	struct net_device *d = hp100_devlist[i];
+	struct hp100_private *p = (struct hp100_private *)d->priv;
+
+	unregister_netdev(d);
+	release_region(d->base_addr, HP100_REGION_SIZE);
+
+	if (p->mode == 1) /* busmaster */
+		kfree(p->page_vaddr); 
+	if (p->mem_ptr_virt)
+		iounmap(p->mem_ptr_virt);
+	kfree(d->priv);
+	d->priv = NULL;
+	kfree(d);
+	hp100_devlist[i] = NULL;
+}
 
 /*
  * Note: if you have more than five 100vg cards in your pc, feel free to
@@ -3051,6 +3071,8 @@
     {
       /* Create device and set basics args */
       hp100_devlist[i] = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+      if (!hp100_devlist[i])
+	goto fail;
       memset(hp100_devlist[i], 0x00, sizeof(struct net_device));
 #if LINUX_VERSION_CODE >= 0x020362	/* 2.3.99-pre7 */
       memcpy(hp100_devlist[i]->name, hp100_name[i], IFNAMSIZ);	/* Copy name */
@@ -3073,6 +3095,13 @@
     }			/* Loop over all devices */
 
   return cards > 0 ? 0 : -ENODEV;
+ fail:
+  while (cards && --i)
+	  if (hp100_devlist[i]) {
+		release_dev(i);
+		--cards;
+	  }
+  return -ENOMEM;
 }
 
 void cleanup_module( void )
@@ -3082,18 +3111,7 @@
   /* TODO: Check if all skb's are released/freed. */
   for(i = 0; i < 5; i++)
     if(hp100_devlist[i] != (struct net_device *) NULL)
-      {
-	unregister_netdev( hp100_devlist[i] );
-	release_region( hp100_devlist[i]->base_addr, HP100_REGION_SIZE );
-	if( ((struct hp100_private *)hp100_devlist[i]->priv)->mode==1 ) /* busmaster */
-	  kfree( ((struct hp100_private *)hp100_devlist[i]->priv)->page_vaddr ); 
-	if ( ((struct hp100_private *)hp100_devlist[i]->priv) -> mem_ptr_virt )
-	  iounmap( ((struct hp100_private *)hp100_devlist[i]->priv) -> mem_ptr_virt );
-	kfree( hp100_devlist[i]->priv );
-	hp100_devlist[i]->priv = NULL;
-	kfree(hp100_devlist[i]);
-	hp100_devlist[i] = (struct net_device *) NULL;
-      }
+	    release_dev(i);
 }
 
 #endif		/* MODULE */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
