Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRAFUaX>; Sat, 6 Jan 2001 15:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132225AbRAFUaN>; Sat, 6 Jan 2001 15:30:13 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:63236 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129538AbRAFUaF>;
	Sat, 6 Jan 2001 15:30:05 -0500
Message-ID: <3A578F27.D2A9DF52@candelatech.com>
Date: Sat, 06 Jan 2001 14:33:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hoping that I can get a few comments on this code.  It was added
to (significantly) speed up things like 'ifconfig -a' when running with
4000 or so VLAN devices.  It should also help other instances with lots
of (virtual) devices, like FrameRelay, ATM, and possibly virtual IP
interfaces.  It probably won't help 'normal' users much, and in it's final
form, should probably be a selectable option in the config process.

Anyway, let me know what you think!

Patch to net/core/dev.c of 2.4.0 fame:

*** ../../../linux/net/core/dev.c	Mon Dec 11 14:29:35 2000
--- dev.c	Sat Jan  6 14:14:10 2001
***************
*** 1,3 ****
! /*
   * 	NET3	Protocol independent device support routines.
   *
--- 1,3 ----
! /* -*- linux-c -*-
   * 	NET3	Protocol independent device support routines.
   *
***************
*** 132,138 ****
   *
   *	Why 16. Because with 16 the only overlap we get on a hash of the
!  *	low nibble of the protocol value is RARP/SNAP/X.25. 
   *
   *		0800	IP
   *		0001	802.3
   *		0002	AX.25
--- 133,147 ----
   *
   *	Why 16. Because with 16 the only overlap we get on a hash of the
!  *	low nibble of the protocol value is RARP/SNAP/X.25.
!  *
!  *      NOTE:  That is no longer true with the addition of VLAN tags.  Not
!  *             sure which should go first, but I bet it won't make much
!  *             difference if we are running VLANs.  The good news is that
!  *             this protocol won't be in the list unless compiled in, so
!  *             the average user (w/out VLANs) will not be adversly affected.
!  *             --BLG
   *
   *		0800	IP
+  *		8100    802.1Q VLAN
   *		0001	802.3
   *		0002	AX.25
***************
*** 179,182 ****
--- 188,435 ----
  
  
+ #define BENS_FAST_DEV_LOOKUP
+ #ifdef BENS_FAST_DEV_LOOKUP
+ /* Fash Device Lookup code.  Should give much better than
+  * linear speed when looking for devices by idx or name.
+  * --Ben (greearb@candelatech.com)
+  */
+ #define FDL_HASH_LEN 256
+ 
+ /* #define FDL_DEBUG */
+ 
+ struct dev_hash_node {
+         struct net_device* dev;
+         struct dev_hash_node* next;
+ };
+ 
+ struct dev_hash_node* fdl_name_base[FDL_HASH_LEN];/* hashed by name */
+ struct dev_hash_node* fdl_idx_base[FDL_HASH_LEN]; /* hashed by index */
+ int fdl_initialized_yet = 0;
+ 
+ /* TODO:  Make these inline methods */
+ /* Nice cheesy little hash method to be used on device-names (eth0, ppp0, etc) */
+ int fdl_calc_name_idx(const char* dev_name) {
+         int tmp = 0;
+         int i;
+ #ifdef FDL_DEBUG
+         printk(KERN_ERR "fdl_calc_name_idx, name: %s\n", dev_name);
+ #endif
+         for (i = 0; dev_name[i]; i++) {
+                 tmp += (int)(dev_name[i]);
+         }
+         if (i > 3) {
+                 tmp += (dev_name[i-2] * 10); /* might add a little spread to the hash */
+                 tmp += (dev_name[i-3] * 100); /* might add a little spread to the hash */
+         }
+ #ifdef FDL_DEBUG
+         printk(KERN_ERR "fdl_calc_name_idx, rslt: %i\n", (int)(tmp % FDL_HASH_LEN));
+ #endif
+         return (tmp % FDL_HASH_LEN);
+ }
+ 
+ int fdl_calc_index_idx(const int ifindex) {
+         return (ifindex % FDL_HASH_LEN);
+ }
+ 
+ 
+ /* Better have a lock on the dev_base before calling this... */
+ int __fdl_ensure_init(void) {
+ #ifdef FDL_DEBUG
+         printk(KERN_ERR "__fdl_ensure_init, enter\n");
+ #endif
+         if (! fdl_initialized_yet) {
+                 /* only do this once.. */
+                 int i;
+                 int idx = 0; /* into the hash table */
+                 struct net_device* dev = dev_base;
+                 struct dev_hash_node* dhn;
+ 
+ #ifdef FDL_DEBUG
+                 printk(KERN_ERR "__fdl_ensure_init, doing real work...");
+ #endif
+ 
+                 fdl_initialized_yet = 1; /* it has been attempted at least... */
+ 
+                 for (i = 0; i<FDL_HASH_LEN; i++) {
+                         fdl_name_base[i] = NULL;
+                         fdl_idx_base[i] = NULL;
+                 }
+ 
+                 /* add any current devices to the hash tables at this time.  Note that
+                  * this method must be called with locks on the dev_base acquired.
+                  */
+                 while (dev) {
+ 
+ #ifdef FDL_DEBUG
+                         printk(KERN_ERR "__fdl_ensure_init, dev: %p dev: %s, idx: %i\n", dev, dev->name, idx);
+ #endif
+                         /* first, take care of the hash-by-name */
+                         idx = fdl_calc_name_idx(dev->name);
+                         dhn = kmalloc(sizeof(struct dev_hash_node), GFP_ATOMIC);
+                         if (dhn) {
+                                 dhn->dev = dev;
+                                 dhn->next = fdl_name_base[idx];
+                                 fdl_name_base[idx] = dhn;
+                         }
+                         else {
+                                 /* Nasty..couldn't get memory... */
+                                 return -ENOMEM;
+                         }
+ 
+                         /* now, do the hash-by-idx */
+                         idx = fdl_calc_index_idx(dev->ifindex);
+                         dhn = kmalloc(sizeof(struct dev_hash_node), GFP_ATOMIC);
+                         if (dhn) {
+                                 dhn->dev = dev;
+                                 dhn->next = fdl_idx_base[idx];
+                                 fdl_idx_base[idx] = dhn;
+                         }
+                         else {
+                                 /* Nasty..couldn't get memory... */
+                                 return -ENOMEM;
+                         }
+          
+                         dev = dev->next;
+                 }
+                 fdl_initialized_yet = 2; /* initialization actually worked */
+         }
+ #ifdef FDL_DEBUG
+         printk(KERN_ERR "__fdl_ensure_init, end, fdl_initialized_yet: %i\n", fdl_initialized_yet);
+ #endif
+         if (fdl_initialized_yet == 2) {
+                 return 0;
+         }
+         else {
+                 return -1;
+         }
+ }/* fdl_ensure_init */
+ 
+ 
+ /* called from register_netdevice, assumes dev is locked, and that no one
+  * will be calling __find_dev_by_name before this exits.. etc.
+  */
+ int __fdl_register_netdevice(struct net_device* dev) {
+         if (__fdl_ensure_init() == 0) {
+                 /* first, take care of the hash-by-name */
+                 int idx = fdl_calc_name_idx(dev->name);
+                 struct dev_hash_node* dhn = kmalloc(sizeof(struct dev_hash_node), GFP_ATOMIC);
+ 
+ #ifdef FDL_DEBUG
+                 printk(KERN_ERR "__fdl_register_netdevice, dev: %p dev: %s, idx: %i", dev, dev->name, idx);
+ #endif
+ 
+                 if (dhn) {
+                         dhn->dev = dev;
+                         dhn->next = fdl_name_base[idx];
+                         fdl_name_base[idx] = dhn;
+                 }
+                 else {
+                         /* Nasty..couldn't get memory... */
+                         /* Don't try to use these hash tables any more... */
+                         fdl_initialized_yet = 1; /* tried, but failed */
+                         return -ENOMEM;
+                 }
+       
+                 /* now, do the hash-by-idx */
+                 idx = fdl_calc_index_idx(dev->ifindex);
+                 dhn = kmalloc(sizeof(struct dev_hash_node), GFP_ATOMIC);
+ 
+ #ifdef FDL_DEBUG
+                 printk(KERN_ERR "__fdl_register_netdevice, ifindex: %i, idx: %i", dev->ifindex, idx);
+ #endif
+ 
+                 if (dhn) {
+                         dhn->dev = dev;
+                         dhn->next = fdl_idx_base[idx];
+                         fdl_idx_base[idx] = dhn;
+                 }
+                 else {
+                         /* Nasty..couldn't get memory... */
+                         /* Don't try to use these hash tables any more... */
+                         fdl_initialized_yet = 1; /* tried, but failed */
+                         return -ENOMEM;
+                 }
+         }
+         return 0;
+ } /* fdl_register_netdevice */
+ 
+ 
+ /* called from register_netdevice, assumes dev is locked, and that no one
+  * will be calling __find_dev_by_name, etc.  Returns 0 if found & removed one,
+  * returns -1 otherwise.
+  */
+ int __fdl_unregister_netdevice(struct net_device* dev) {
+         int retval = -1;
+         if (fdl_initialized_yet == 2) { /* If we've been initialized correctly... */
+                 /* first, take care of the hash-by-name */
+                 int idx = fdl_calc_name_idx(dev->name);
+                 struct dev_hash_node* prev = fdl_name_base[idx];
+                 struct dev_hash_node* cur = NULL;
+ 
+ #ifdef FDL_DEBUG
+                 printk(KERN_ERR "__fdl_unregister_netdevice, dev: %p dev: %s, idx: %i", dev, dev->name, idx);
+ #endif
+ 
+                 if (prev) {
+                         if (strcmp(dev->name, prev->dev->name) == 0) {
+                                 /* it's the first one... */
+                                 fdl_name_base[idx] = prev->next;
+                                 kfree(prev);
+                                 retval = 0;
+                         }
+                         else {
+                                 cur = prev->next;
+                                 while (cur) {
+                                         if (strcmp(dev->name, cur->dev->name) == 0) {
+                                                 prev->next = cur->next;
+                                                 kfree(cur);
+                                                 retval = 0;
+                                                 break;
+                                         }
+                                         else {
+                                                 prev = cur;
+                                                 cur = cur->next;
+                                         }
+                                 }
+                         }
+                 }
+ 
+                 /* Now, the hash-by-index */
+                 idx = fdl_calc_index_idx(dev->ifindex);
+                 prev = fdl_idx_base[idx];
+                 cur = NULL;
+                 if (prev) {
+                         if (dev->ifindex == prev->dev->ifindex) {
+                                 /* it's the first one... */
+                                 fdl_idx_base[idx] = prev->next;
+                                 kfree(prev);
+                                 retval = 0;
+                         }
+                         else {
+                                 cur = prev->next;
+                                 while (cur) {
+                                         if (dev->ifindex == cur->dev->ifindex) {
+                                                 prev->next = cur->next;
+                                                 kfree(cur);
+                                                 retval = 0;
+                                                 break;
+                                         }
+                                         else {
+                                                 prev = cur;
+                                                 cur = cur->next;
+                                         }
+                                 }
+                         }
+                 }
+         }/* if we ensured init OK */
+         return retval;
+ } /* fdl_unregister_netdevice */
+ 
+ 
+ 
+ #endif   /* BENS_FAST_DEV_LOOKUP */
+ 
+ 
+ 
  /******************************************************************************************
  
***************
*** 397,401 ****
  {
  	struct net_device *dev;
! 
  	for (dev = dev_base; dev != NULL; dev = dev->next) {
  		if (strcmp(dev->name, name) == 0)
--- 650,673 ----
  {
  	struct net_device *dev;
!         
! #ifdef BENS_FAST_DEV_LOOKUP
!         int idx = fdl_calc_name_idx(name);
!         struct dev_hash_node* dhn;
!         if (fdl_initialized_yet == 2) {
! #ifdef FDL_DEBUG
!                 printk(KERN_ERR "__dev_get_by_name, name: %s  idx: %i\n", name, idx);
! #endif
!                 dhn = fdl_name_base[idx];
!                 while (dhn) {
!                         if (strcmp(dhn->dev->name, name) == 0) {
!                                 /* printk(KERN_ERR "__dev_get_by_name, found it: %p\n", dhn->dev); */
!                                 return dhn->dev;
!                         }
!                         dhn = dhn->next;
!                 }
!                 /* printk(KERN_ERR "__dev_get_by_name, didn't find it for name: %s\n", name); */
!                 return NULL;
!         }
! #endif
  	for (dev = dev_base; dev != NULL; dev = dev->next) {
  		if (strcmp(dev->name, name) == 0)
***************
*** 473,476 ****
--- 745,762 ----
  	struct net_device *dev;
  
+ #ifdef BENS_FAST_DEV_LOOKUP
+         int idx = fdl_calc_index_idx(ifindex);
+         struct dev_hash_node* dhn;
+         if (fdl_initialized_yet == 2) { /* have we gone through initialization before... */
+                 dhn = fdl_idx_base[idx];
+                 while (dhn) {
+                         if (dhn->dev->ifindex == ifindex)
+                                 return dhn->dev;
+                         dhn = dhn->next;
+                 }
+                 return NULL;
+         }
+ #endif
+ 
  	for (dev = dev_base; dev != NULL; dev = dev->next) {
  		if (dev->ifindex == ifindex)
***************
*** 550,555 ****
  	/*
  	 *	If you need over 100 please also fix the algorithm...
  	 */
! 	for (i = 0; i < 100; i++) {
  		sprintf(buf,name,i);
  		if (__dev_get_by_name(buf) == NULL) {
--- 836,843 ----
  	/*
  	 *	If you need over 100 please also fix the algorithm...
+          *      Increased it to deal with VLAN interfaces.  It is unlikely
+          *      that this many will ever be added, but it can't hurt! -BLG
  	 */
! 	for (i = 0; i < 8192; i++) {
  		sprintf(buf,name,i);
  		if (__dev_get_by_name(buf) == NULL) {
***************
*** 558,562 ****
  		}
  	}
! 	return -ENFILE;	/* Over 100 of the things .. bail out! */
  }
  
--- 846,850 ----
  		}
  	}
! 	return -ENFILE;	/* Over 8192 of the things .. bail out! */
  }
  
***************
*** 2068,2073 ****
--- 2356,2369 ----
  			if (__dev_get_by_name(ifr->ifr_newname))
  				return -EEXIST;
+ #ifdef BENS_FAST_DEV_LOOKUP
+                         write_lock_bh(&dev_base_lock); /* gotta lock it to remove stuff */
+                         __fdl_unregister_netdevice(dev); /* remove it from the hash.. */
+ #endif
  			memcpy(dev->name, ifr->ifr_newname, IFNAMSIZ);
  			dev->name[IFNAMSIZ-1] = 0;
+ #ifdef BENS_FAST_DEV_LOOKUP
+                         __fdl_register_netdevice(dev);
+                         write_unlock_bh(&dev_base_lock); /* gotta lock it to add stuff too */
+ #endif                        
  			notifier_call_chain(&netdev_chain, NETDEV_CHANGENAME, dev);
  			return 0;
***************
*** 2343,2346 ****
--- 2639,2648 ----
  		dev->next = NULL;
  		write_lock_bh(&dev_base_lock);
+ #ifdef BENS_FAST_DEV_LOOKUP
+                 /* Must do this before dp is set to dev, or it could be added twice, once
+                  * on initialization based on dev_base, and once again after that...
+                  */
+                 __fdl_register_netdevice(dev);
+ #endif
  		*dp = dev;
  		dev_hold(dev);
***************
*** 2397,2400 ****
--- 2699,2708 ----
  	dev_init_scheduler(dev);
  	write_lock_bh(&dev_base_lock);
+ #ifdef BENS_FAST_DEV_LOOKUP
+         /* Must do this before dp is set to dev, or it could be added twice, once
+          * on initialization based on dev_base, and once again after that...
+          */
+         __fdl_register_netdevice(dev);
+ #endif
  	*dp = dev;
  	dev_hold(dev);
***************
*** 2469,2473 ****
  			write_lock_bh(&dev_base_lock);
  			*dp = d->next;
! 			write_unlock_bh(&dev_base_lock);
  			break;
  		}
--- 2777,2784 ----
  			write_lock_bh(&dev_base_lock);
  			*dp = d->next;
! #ifdef BENS_FAST_DEV_LOOKUP
!                         __fdl_unregister_netdevice(dev);
! #endif
!                         write_unlock_bh(&dev_base_lock);
  			break;
  		}

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
