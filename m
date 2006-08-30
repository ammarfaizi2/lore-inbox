Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWH3SXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWH3SXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWH3SXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:23:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37007 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751291AbWH3SXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:23:42 -0400
In-Reply-To: <200608301143.35320.arnd.bergmann@de.ibm.com>
Subject: Re: [openib-general] [PATCH 02/13] IB/ehca: includes
To: abergman@de.ibm.com
Cc: abergman@de.ibm.com, Christoph Raisch <RAISCH@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Marcus Eder <MEDER@de.ibm.com>, openib-general@openib.org,
       openib-general-bounces@openib.org
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OFA5C40C75.6656531A-ONC12571DA.00649AA7-C12571DA.00650A91@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Wed, 30 Aug 2006 20:27:51 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 30/08/2006 20:27:52
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> There are a few places in the driver where you declare
> external variables (mostly ehca_module and ehca_debug_level)
> from C files instead of a header.  This sometimes leads
> to bugs when a type changes and is therefore considered
> bad style.
Good point. See patch attached below.

> Moreover, for some of your more heavily used caches, you may
> want to look into using constructor/destructor calls to
> speed up allocation.
That makes sense. Will look into this for a later patch.

Thanks!
Nam


 Makefile       |    1
 ehca_av.c      |   29 +++++++---
 ehca_classes.h |   27 +++++----
 ehca_cq.c      |   27 +++++++--
 ehca_eq.c      |   14 ----
 ehca_irq.c     |    1
 ehca_main.c    |  164
++++++++++++++++++++-------------------------------------
 ehca_mrmw.c    |   45 +++++++++++----
 ehca_pd.c      |   25 +++++++-
 ehca_qp.c      |   32 +++++++----
 ehca_reqs.c    |    2
 ehca_sqp.c     |    2
 hcp_if.c       |    1
 hcp_phyp.h     |    4 -
 ipz_pt_fn.c    |    2
 15 files changed, 198 insertions(+), 178 deletions(-)


diff -Nurp infiniband/drivers/infiniband/hw/ehca/Makefile
infiniband_work/drivers/infiniband/hw/ehca/Makefile
--- infiniband/drivers/infiniband/hw/ehca/Makefile    2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/Makefile     2006-08-30
20:00:17.000000000 +0200
@@ -10,6 +10,7 @@

 obj-$(CONFIG_INFINIBAND_EHCA) += ib_ehca.o

+
 ib_ehca-objs  = ehca_main.o ehca_hca.o ehca_mcast.o ehca_pd.o ehca_av.o
ehca_eq.o \
            ehca_cq.o ehca_qp.o ehca_sqp.o ehca_mrmw.o ehca_reqs.o
ehca_irq.o \
            ehca_uverbs.o ipz_pt_fn.o hcp_if.o hcp_phyp.o
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_av.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_av.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_av.c   2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_av.c    2006-08-30
20:00:16.000000000 +0200
@@ -48,16 +48,16 @@
 #include "ehca_iverbs.h"
 #include "hcp_if.h"

+static struct kmem_cache *av_cache;
+
 struct ib_ah *ehca_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr)
 {
-     extern struct ehca_module ehca_module;
-     extern int ehca_static_rate;
      int ret;
      struct ehca_av *av;
      struct ehca_shca *shca = container_of(pd->device, struct ehca_shca,
                                    ib_device);

-     av = kmem_cache_alloc(ehca_module.cache_av, SLAB_KERNEL);
+     av = kmem_cache_alloc(av_cache, SLAB_KERNEL);
      if (!av) {
            ehca_err(pd->device, "Out of memory pd=%p ah_attr=%p",
                   pd, ah_attr);
@@ -128,7 +128,7 @@ struct ib_ah *ehca_create_ah(struct ib_p
      return &av->ib_ah;

 create_ah_exit1:
-     kmem_cache_free(ehca_module.cache_av, av);
+     kmem_cache_free(av_cache, av);

      return ERR_PTR(ret);
 }
@@ -238,7 +238,6 @@ int ehca_query_ah(struct ib_ah *ah, stru

 int ehca_destroy_ah(struct ib_ah *ah)
 {
-     extern struct ehca_module ehca_module;
      struct ehca_pd *my_pd = container_of(ah->pd, struct ehca_pd, ib_pd);
      u32 cur_pid = current->tgid;

@@ -249,8 +248,24 @@ int ehca_destroy_ah(struct ib_ah *ah)
            return -EINVAL;
      }

-     kmem_cache_free(ehca_module.cache_av,
-                 container_of(ah, struct ehca_av, ib_ah));
+     kmem_cache_free(av_cache, container_of(ah, struct ehca_av, ib_ah));
+
+     return 0;
+}

+int ehca_init_av_cache(void)
+{
+     av_cache = kmem_cache_create("ehca_cache_av",
+                          sizeof(struct ehca_av), 0,
+                          SLAB_HWCACHE_ALIGN,
+                          NULL, NULL);
+     if (!av_cache)
+           return -ENOMEM;
      return 0;
 }
+
+void ehca_cleanup_av_cache(void)
+{
+     if (av_cache)
+           kmem_cache_destroy(av_cache);
+}
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_classes.h
infiniband_work/drivers/infiniband/hw/ehca/ehca_classes.h
--- infiniband/drivers/infiniband/hw/ehca/ehca_classes.h    2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_classes.h
2006-08-30 20:00:16.000000000 +0200
@@ -63,18 +63,6 @@ struct ehca_av;

 #include "ehca_irq.h"

-struct ehca_module {
-     struct list_head shca_list;
-     spinlock_t shca_lock;
-     struct timer_list timer;
-     kmem_cache_t *cache_pd;
-     kmem_cache_t *cache_cq;
-     kmem_cache_t *cache_qp;
-     kmem_cache_t *cache_av;
-     kmem_cache_t *cache_mr;
-     kmem_cache_t *cache_mw;
-};
-
 struct ehca_eq {
      u32 length;
      struct ipz_queue ipz_queue;
@@ -274,11 +262,26 @@ int ehca_shca_delete(struct ehca_shca *m

 struct ehca_sport *ehca_sport_new(struct ehca_shca *anchor);

+int ehca_init_pd_cache(void);
+void ehca_cleanup_pd_cache(void);
+int ehca_init_cq_cache(void);
+void ehca_cleanup_cq_cache(void);
+int ehca_init_qp_cache(void);
+void ehca_cleanup_qp_cache(void);
+int ehca_init_av_cache(void);
+void ehca_cleanup_av_cache(void);
+int ehca_init_mrmw_cache(void);
+void ehca_cleanup_mrmw_cache(void);
+
 extern spinlock_t ehca_qp_idr_lock;
 extern spinlock_t ehca_cq_idr_lock;
 extern struct idr ehca_qp_idr;
 extern struct idr ehca_cq_idr;

+extern int ehca_static_rate;
+extern int ehca_port_act_time;
+extern int ehca_use_hp_mr;
+
 struct ipzu_queue_resp {
      u64 queue;        /* points to first queue entry */
      u32 qe_size;      /* queue entry size */
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_cq.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_cq.c   2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_cq.c    2006-08-30
20:00:17.000000000 +0200
@@ -50,6 +50,8 @@
 #include "ehca_irq.h"
 #include "hcp_if.h"

+static struct kmem_cache *cq_cache;
+
 int ehca_cq_assign_qp(struct ehca_cq *cq, struct ehca_qp *qp)
 {
      unsigned int qp_num = qp->real_qp_num;
@@ -115,7 +117,6 @@ struct ib_cq *ehca_create_cq(struct ib_d
                       struct ib_ucontext *context,
                       struct ib_udata *udata)
 {
-     extern struct ehca_module ehca_module;
      static const u32 additional_cqe = 20;
      struct ib_cq *cq;
      struct ehca_cq *my_cq;
@@ -133,7 +134,7 @@ struct ib_cq *ehca_create_cq(struct ib_d
      if (cqe >= 0xFFFFFFFF - 64 - additional_cqe)
            return ERR_PTR(-EINVAL);

-     my_cq = kmem_cache_alloc(ehca_module.cache_cq, SLAB_KERNEL);
+     my_cq = kmem_cache_alloc(cq_cache, SLAB_KERNEL);
      if (!my_cq) {
            ehca_err(device, "Out of memory for ehca_cq struct device=%p",
                   device);
@@ -324,14 +325,13 @@ create_cq_exit2:
      spin_unlock_irqrestore(&ehca_cq_idr_lock, flags);

 create_cq_exit1:
-     kmem_cache_free(ehca_module.cache_cq, my_cq);
+     kmem_cache_free(cq_cache, my_cq);

      return cq;
 }

 int ehca_destroy_cq(struct ib_cq *cq)
 {
-     extern struct ehca_module ehca_module;
      u64 h_ret;
      int ret;
      struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
@@ -387,7 +387,7 @@ int ehca_destroy_cq(struct ib_cq *cq)
            return ehca2ib_return_code(h_ret);
      }
      ipz_queue_dtor(&my_cq->ipz_queue);
-     kmem_cache_free(ehca_module.cache_cq, my_cq);
+     kmem_cache_free(cq_cache, my_cq);

      return 0;
 }
@@ -408,3 +408,20 @@ int ehca_resize_cq(struct ib_cq *cq, int

      return -EFAULT;
 }
+
+int ehca_init_cq_cache(void)
+{
+     cq_cache = kmem_cache_create("ehca_cache_cq",
+                            sizeof(struct ehca_cq), 0,
+                            SLAB_HWCACHE_ALIGN,
+                            NULL, NULL);
+     if (!cq_cache)
+           return -ENOMEM;
+     return 0;
+}
+
+void ehca_cleanup_cq_cache(void)
+{
+     if (cq_cache)
+           kmem_cache_destroy(cq_cache);
+}
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_eq.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_eq.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_eq.c   2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_eq.c    2006-08-30
20:00:16.000000000 +0200
@@ -163,20 +163,6 @@ void *ehca_poll_eq(struct ehca_shca *shc
      return eqe;
 }

-void ehca_poll_eqs(unsigned long data)
-{
-     struct ehca_shca *shca;
-     struct ehca_module *module = (struct ehca_module*)data;
-
-     spin_lock(&module->shca_lock);
-     list_for_each_entry(shca, &module->shca_list, shca_list) {
-           if (shca->eq.is_initialized)
-                 ehca_tasklet_eq((unsigned long)(void*)shca);
-     }
-     mod_timer(&module->timer, jiffies + HZ);
-     spin_unlock(&module->shca_lock);
-}
-
 int ehca_destroy_eq(struct ehca_shca *shca, struct ehca_eq *eq)
 {
      unsigned long flags;
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_irq.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_irq.c  2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_irq.c   2006-08-30
20:00:16.000000000 +0200
@@ -427,7 +427,6 @@ void ehca_tasklet_eq(unsigned long data)
                        /* TODO: better structure */
                        if (EHCA_BMASK_GET(EQE_COMPLETION_EVENT,
                                       eqe_value)) {
-                             extern struct idr ehca_cq_idr;
                              unsigned long flags;
                              u32 token;
                              struct ehca_cq *cq;
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_main.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_main.c 2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c  2006-08-30
20:01:34.000000000 +0200
@@ -4,6 +4,7 @@
  *  module start stop, hca detection
  *
  *  Authors: Heiko J Schick <schickhj@de.ibm.com>
+ *           Hoang-Nam Nguyen <hnguyen@de.ibm.com>
  *
  *  Copyright (c) 2005 IBM Corporation
  *
@@ -47,7 +48,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0014");
+MODULE_VERSION("SVNEHCA_0015");

 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -92,129 +93,69 @@ spinlock_t ehca_cq_idr_lock;
 DEFINE_IDR(ehca_qp_idr);
 DEFINE_IDR(ehca_cq_idr);

-struct ehca_module ehca_module;
+static struct list_head shca_list; /* list of all registered ehcas */
+static spinlock_t shca_list_lock;

-int ehca_create_slab_caches(struct ehca_module *ehca_module)
+static struct timer_list poll_eqs_timer;
+
+static int ehca_create_slab_caches(void)
 {
      int ret;

-     ehca_module->cache_pd =
-           kmem_cache_create("ehca_cache_pd",
-                         sizeof(struct ehca_pd),
-                         0, SLAB_HWCACHE_ALIGN,
-                         NULL, NULL);
-     if (!ehca_module->cache_pd) {
+     ret = ehca_init_pd_cache();
+     if (ret) {
            ehca_gen_err("Cannot create PD SLAB cache.");
-           ret = -ENOMEM;
-           goto create_slab_caches1;
+           return ret;
      }

-     ehca_module->cache_cq =
-           kmem_cache_create("ehca_cache_cq",
-                         sizeof(struct ehca_cq),
-                         0, SLAB_HWCACHE_ALIGN,
-                         NULL, NULL);
-     if (!ehca_module->cache_cq) {
+     ret = ehca_init_cq_cache();
+     if (ret) {
            ehca_gen_err("Cannot create CQ SLAB cache.");
-           ret = -ENOMEM;
            goto create_slab_caches2;
      }

-     ehca_module->cache_qp =
-           kmem_cache_create("ehca_cache_qp",
-                         sizeof(struct ehca_qp),
-                         0, SLAB_HWCACHE_ALIGN,
-                         NULL, NULL);
-     if (!ehca_module->cache_qp) {
+     ret = ehca_init_qp_cache();
+     if (ret) {
            ehca_gen_err("Cannot create QP SLAB cache.");
-           ret = -ENOMEM;
            goto create_slab_caches3;
      }

-     ehca_module->cache_av =
-           kmem_cache_create("ehca_cache_av",
-                         sizeof(struct ehca_av),
-                         0, SLAB_HWCACHE_ALIGN,
-                         NULL, NULL);
-     if (!ehca_module->cache_av) {
+     ret = ehca_init_av_cache();
+     if (ret) {
            ehca_gen_err("Cannot create AV SLAB cache.");
-           ret = -ENOMEM;
            goto create_slab_caches4;
      }

-     ehca_module->cache_mw =
-           kmem_cache_create("ehca_cache_mw",
-                         sizeof(struct ehca_mw),
-                         0, SLAB_HWCACHE_ALIGN,
-                         NULL, NULL);
-     if (!ehca_module->cache_mw) {
-           ehca_gen_err("Cannot create MW SLAB cache.");
-           ret = -ENOMEM;
+     ret = ehca_init_mrmw_cache();
+     if (ret) {
+           ehca_gen_err("Cannot create MR&MW SLAB cache.");
            goto create_slab_caches5;
      }

-     ehca_module->cache_mr =
-           kmem_cache_create("ehca_cache_mr",
-                         sizeof(struct ehca_mr),
-                         0, SLAB_HWCACHE_ALIGN,
-                         NULL, NULL);
-     if (!ehca_module->cache_mr) {
-           ehca_gen_err("Cannot create MR SLAB cache.");
-           ret = -ENOMEM;
-           goto create_slab_caches6;
-     }
-
      return 0;

-create_slab_caches6:
-     kmem_cache_destroy(ehca_module->cache_mw);
-
 create_slab_caches5:
-     kmem_cache_destroy(ehca_module->cache_av);
+     ehca_cleanup_av_cache();

 create_slab_caches4:
-     kmem_cache_destroy(ehca_module->cache_qp);
+     ehca_cleanup_qp_cache();

 create_slab_caches3:
-     kmem_cache_destroy(ehca_module->cache_cq);
+     ehca_cleanup_cq_cache();

 create_slab_caches2:
-     kmem_cache_destroy(ehca_module->cache_pd);
-
-create_slab_caches1:
+     ehca_cleanup_pd_cache();

      return ret;
 }

-int ehca_destroy_slab_caches(struct ehca_module *ehca_module)
+static void ehca_destroy_slab_caches(void)
 {
-     int ret;
-
-     ret = kmem_cache_destroy(ehca_module->cache_pd);
-     if (ret)
-           ehca_gen_err("Cannot destroy PD SLAB cache. ret=%x", ret);
-
-     ret = kmem_cache_destroy(ehca_module->cache_cq);
-     if (ret)
-           ehca_gen_err("Cannot destroy CQ SLAB cache. ret=%x", ret);
-
-     ret = kmem_cache_destroy(ehca_module->cache_qp);
-     if (ret)
-           ehca_gen_err("Cannot destroy QP SLAB cache. ret=%x", ret);
-
-     ret = kmem_cache_destroy(ehca_module->cache_av);
-     if (ret)
-           ehca_gen_err("Cannot destroy AV SLAB cache. ret=%x", ret);
-
-     ret = kmem_cache_destroy(ehca_module->cache_mw);
-     if (ret)
-           ehca_gen_err("Cannot destroy MW SLAB cache. ret=%x", ret);
-
-     ret = kmem_cache_destroy(ehca_module->cache_mr);
-     if (ret)
-           ehca_gen_err("Cannot destroy MR SLAB cache. ret=%x", ret);
-
-     return 0;
+     ehca_cleanup_mrmw_cache();
+     ehca_cleanup_av_cache();
+     ehca_cleanup_qp_cache();
+     ehca_cleanup_cq_cache();
+     ehca_cleanup_pd_cache();
 }

 #define EHCA_HCAAVER  EHCA_BMASK_IBM(32,39)
@@ -682,9 +623,9 @@ static int __devinit ehca_probe(struct i

      ehca_create_device_sysfs(dev);

-     spin_lock(&ehca_module.shca_lock);
-     list_add(&shca->shca_list, &ehca_module.shca_list);
-     spin_unlock(&ehca_module.shca_lock);
+     spin_lock(&shca_list_lock);
+     list_add(&shca->shca_list, &shca_list);
+     spin_unlock(&shca_list_lock);

      return 0;

@@ -767,9 +708,9 @@ static int __devexit ehca_remove(struct

      ib_dealloc_device(&shca->ib_device);

-     spin_lock(&ehca_module.shca_lock);
+     spin_lock(&shca_list_lock);
      list_del(&shca->shca_list);
-     spin_unlock(&ehca_module.shca_lock);
+     spin_unlock(&shca_list_lock);

      return ret;
 }
@@ -790,26 +731,39 @@ static struct ibmebus_driver ehca_driver
      .remove   = ehca_remove,
 };

+void ehca_poll_eqs(unsigned long data)
+{
+     struct ehca_shca *shca;
+
+     spin_lock(&shca_list_lock);
+     list_for_each_entry(shca, &shca_list, shca_list) {
+           if (shca->eq.is_initialized)
+                 ehca_tasklet_eq((unsigned long)(void*)shca);
+     }
+     mod_timer(&poll_eqs_timer, jiffies + HZ);
+     spin_unlock(&shca_list_lock);
+}
+
 int __init ehca_module_init(void)
 {
      int ret;

      printk(KERN_INFO "eHCA Infiniband Device Driver "
-                      "(Rel.: SVNEHCA_0014)\n");
+                      "(Rel.: SVNEHCA_0015)\n");
      idr_init(&ehca_qp_idr);
      idr_init(&ehca_cq_idr);
      spin_lock_init(&ehca_qp_idr_lock);
      spin_lock_init(&ehca_cq_idr_lock);

-     INIT_LIST_HEAD(&ehca_module.shca_list);
-     spin_lock_init(&ehca_module.shca_lock);
+     INIT_LIST_HEAD(&shca_list);
+     spin_lock_init(&shca_list_lock);

      if ((ret = ehca_create_comp_pool())) {
            ehca_gen_err("Cannot create comp pool.");
            return ret;
      }

-     if ((ret = ehca_create_slab_caches(&ehca_module))) {
+     if ((ret = ehca_create_slab_caches())) {
            ehca_gen_err("Cannot create SLAB caches");
            ret = -ENOMEM;
            goto module_init1;
@@ -827,17 +781,16 @@ int __init ehca_module_init(void)
            ehca_gen_err("WARNING!!!");
            ehca_gen_err("It is possible to lose interrupts.");
      } else {
-           init_timer(&ehca_module.timer);
-           ehca_module.timer.function = ehca_poll_eqs;
-           ehca_module.timer.data = (unsigned long)&ehca_module;
-           ehca_module.timer.expires = jiffies + HZ;
-           add_timer(&ehca_module.timer);
+           init_timer(&poll_eqs_timer);
+           poll_eqs_timer.function = ehca_poll_eqs;
+           poll_eqs_timer.expires = jiffies + HZ;
+           add_timer(&poll_eqs_timer);
      }

      return 0;

 module_init2:
-     ehca_destroy_slab_caches(&ehca_module);
+     ehca_destroy_slab_caches();

 module_init1:
      ehca_destroy_comp_pool();
@@ -847,13 +800,12 @@ module_init1:
 void __exit ehca_module_exit(void)
 {
      if (ehca_poll_all_eqs == 1)
-           del_timer_sync(&ehca_module.timer);
+           del_timer_sync(&poll_eqs_timer);

      ehca_remove_driver_sysfs(&ehca_driver);
      ibmebus_unregister_driver(&ehca_driver);

-     if (ehca_destroy_slab_caches(&ehca_module) != 0)
-           ehca_gen_err("Cannot destroy SLAB caches");
+     ehca_destroy_slab_caches();

      ehca_destroy_comp_pool();

diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_mrmw.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_mrmw.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_mrmw.c 2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_mrmw.c  2006-08-30
20:00:16.000000000 +0200
@@ -46,14 +46,14 @@
 #include "hcp_if.h"
 #include "hipz_hw.h"

-extern int ehca_use_hp_mr;
+static struct kmem_cache *mr_cache;
+static struct kmem_cache *mw_cache;

 static struct ehca_mr *ehca_mr_new(void)
 {
-     extern struct ehca_module ehca_module;
      struct ehca_mr *me;

-     me = kmem_cache_alloc(ehca_module.cache_mr, SLAB_KERNEL);
+     me = kmem_cache_alloc(mr_cache, SLAB_KERNEL);
      if (me) {
            memset(me, 0, sizeof(struct ehca_mr));
            spin_lock_init(&me->mrlock);
@@ -65,17 +65,14 @@ static struct ehca_mr *ehca_mr_new(void)

 static void ehca_mr_delete(struct ehca_mr *me)
 {
-     extern struct ehca_module ehca_module;
-
-     kmem_cache_free(ehca_module.cache_mr, me);
+     kmem_cache_free(mr_cache, me);
 }

 static struct ehca_mw *ehca_mw_new(void)
 {
-     extern struct ehca_module ehca_module;
      struct ehca_mw *me;

-     me = kmem_cache_alloc(ehca_module.cache_mw, SLAB_KERNEL);
+     me = kmem_cache_alloc(mw_cache, SLAB_KERNEL);
      if (me) {
            memset(me, 0, sizeof(struct ehca_mw));
            spin_lock_init(&me->mwlock);
@@ -87,9 +84,7 @@ static struct ehca_mw *ehca_mw_new(void)

 static void ehca_mw_delete(struct ehca_mw *me)
 {
-     extern struct ehca_module ehca_module;
-
-     kmem_cache_free(ehca_module.cache_mw, me);
+     kmem_cache_free(mw_cache, me);
 }

 /*----------------------------------------------------------------------*/
@@ -2236,3 +2231,31 @@ void ehca_mr_deletenew(struct ehca_mr *m
      mr->nr_of_pages   = 0;
      mr->pagearray     = NULL;
 } /* end ehca_mr_deletenew() */
+
+int ehca_init_mrmw_cache(void)
+{
+     mr_cache = kmem_cache_create("ehca_cache_mr",
+                            sizeof(struct ehca_mr), 0,
+                            SLAB_HWCACHE_ALIGN,
+                            NULL, NULL);
+     if (!mr_cache)
+           return -ENOMEM;
+     mw_cache = kmem_cache_create("ehca_cache_mw",
+                            sizeof(struct ehca_mw), 0,
+                            SLAB_HWCACHE_ALIGN,
+                            NULL, NULL);
+     if (!mw_cache) {
+           kmem_cache_destroy(mr_cache);
+           mr_cache = NULL;
+           return -ENOMEM;
+     }
+     return 0;
+}
+
+void ehca_cleanup_mrmw_cache(void)
+{
+     if (mr_cache)
+           kmem_cache_destroy(mr_cache);
+     if (mw_cache)
+           kmem_cache_destroy(mw_cache);
+}
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_pd.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_pd.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_pd.c   2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_pd.c    2006-08-30
20:00:16.000000000 +0200
@@ -43,13 +43,14 @@
 #include "ehca_tools.h"
 #include "ehca_iverbs.h"

+static struct kmem_cache *pd_cache;
+
 struct ib_pd *ehca_alloc_pd(struct ib_device *device,
                      struct ib_ucontext *context, struct ib_udata *udata)
 {
-     extern struct ehca_module ehca_module;
      struct ehca_pd *pd;

-     pd = kmem_cache_alloc(ehca_module.cache_pd, SLAB_KERNEL);
+     pd = kmem_cache_alloc(pd_cache, SLAB_KERNEL);
      if (!pd) {
            ehca_err(device, "device=%p context=%p out of memory",
                   device, context);
@@ -79,7 +80,6 @@ struct ib_pd *ehca_alloc_pd(struct ib_de

 int ehca_dealloc_pd(struct ib_pd *pd)
 {
-     extern struct ehca_module ehca_module;
      u32 cur_pid = current->tgid;
      struct ehca_pd *my_pd = container_of(pd, struct ehca_pd, ib_pd);

@@ -90,8 +90,25 @@ int ehca_dealloc_pd(struct ib_pd *pd)
            return -EINVAL;
      }

-     kmem_cache_free(ehca_module.cache_pd,
+     kmem_cache_free(pd_cache,
                  container_of(pd, struct ehca_pd, ib_pd));

      return 0;
 }
+
+int ehca_init_pd_cache(void)
+{
+     pd_cache = kmem_cache_create("ehca_cache_pd",
+                            sizeof(struct ehca_pd), 0,
+                            SLAB_HWCACHE_ALIGN,
+                            NULL, NULL);
+     if (!pd_cache)
+           return -ENOMEM;
+     return 0;
+}
+
+void ehca_cleanup_pd_cache(void)
+{
+     if (pd_cache)
+           kmem_cache_destroy(pd_cache);
+}
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_qp.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_qp.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_qp.c   2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_qp.c    2006-08-30
20:00:16.000000000 +0200
@@ -51,6 +51,8 @@
 #include "hcp_if.h"
 #include "hipz_fns.h"

+static struct kmem_cache *qp_cache;
+
 /*
  * attributes not supported by query qp
  */
@@ -387,7 +389,6 @@ struct ib_qp *ehca_create_qp(struct ib_p
                       struct ib_qp_init_attr *init_attr,
                       struct ib_udata *udata)
 {
-     extern struct ehca_module ehca_module;
      static int da_rc_msg_size[]={ 128, 256, 512, 1024, 2048, 4096 };
      static int da_ud_sq_msg_size[]={ 128, 384, 896, 1920, 3968 };
      struct ehca_qp *my_qp;
@@ -449,7 +450,7 @@ struct ib_qp *ehca_create_qp(struct ib_p
      if (pd->uobject && udata)
            context = pd->uobject->context;

-     my_qp = kmem_cache_alloc(ehca_module.cache_qp, SLAB_KERNEL);
+     my_qp = kmem_cache_alloc(qp_cache, SLAB_KERNEL);
      if (!my_qp) {
            ehca_err(pd->device, "pd=%p not enough memory to alloc qp",
pd);
            return ERR_PTR(-ENOMEM);
@@ -716,7 +717,7 @@ create_qp_exit1:
      spin_unlock_irqrestore(&ehca_qp_idr_lock, flags);

 create_qp_exit0:
-     kmem_cache_free(ehca_module.cache_qp, my_qp);
+     kmem_cache_free(qp_cache, my_qp);
      return ERR_PTR(ret);
 }

@@ -728,7 +729,6 @@ create_qp_exit0:
 static int prepare_sqe_rts(struct ehca_qp *my_qp, struct ehca_shca *shca,
                     int *bad_wqe_cnt)
 {
-     extern int ehca_debug_level;
      u64 h_ret;
      struct ipz_queue *squeue;
      void *bad_send_wqe_p, *bad_send_wqe_v;
@@ -797,7 +797,6 @@ static int internal_modify_qp(struct ib_
                        struct ib_qp_attr *attr,
                        int attr_mask, int smi_reset2init)
 {
-     extern int ehca_debug_level;
      enum ib_qp_state qp_cur_state, qp_new_state;
      int cnt, qp_attr_idx, ret = 0;
      enum ib_qp_statetrans statetrans;
@@ -807,7 +806,7 @@ static int internal_modify_qp(struct ib_
            container_of(ibqp->pd->device, struct ehca_shca, ib_device);
      u64 update_mask;
      u64 h_ret;
-     int bad_wqe_cnt;
+     int bad_wqe_cnt = 0;
      int squeue_locked = 0;
      unsigned long spl_flags = 0;

@@ -1253,7 +1251,6 @@ int ehca_query_qp(struct ib_qp *qp,
              struct ib_qp_attr *qp_attr,
              int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
 {
-     extern int ehca_debug_level;
      struct ehca_qp *my_qp = container_of(qp, struct ehca_qp, ib_qp);
      struct ehca_pd *my_pd = container_of(my_qp->ib_qp.pd, struct ehca_pd,
                                   ib_pd);
@@ -1410,7 +1407,6 @@ query_qp_exit1:

 int ehca_destroy_qp(struct ib_qp *ibqp)
 {
-     extern struct ehca_module ehca_module;
      struct ehca_qp *my_qp = container_of(ibqp, struct ehca_qp, ib_qp);
      struct ehca_shca *shca = container_of(ibqp->device, struct ehca_shca,
                                    ib_device);
@@ -1488,6 +1484,23 @@ int ehca_destroy_qp(struct ib_qp *ibqp)

      ipz_queue_dtor(&my_qp->ipz_rqueue);
      ipz_queue_dtor(&my_qp->ipz_squeue);
-     kmem_cache_free(ehca_module.cache_qp, my_qp);
+     kmem_cache_free(qp_cache, my_qp);
      return 0;
 }
+
+int ehca_init_qp_cache(void)
+{
+     qp_cache = kmem_cache_create("ehca_cache_qp",
+                            sizeof(struct ehca_qp), 0,
+                            SLAB_HWCACHE_ALIGN,
+                            NULL, NULL);
+     if (!qp_cache)
+           return -ENOMEM;
+     return 0;
+}
+
+void ehca_cleanup_qp_cache(void)
+{
+     if (qp_cache)
+           kmem_cache_destroy(qp_cache);
+}
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_reqs.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_reqs.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_reqs.c 2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_reqs.c  2006-08-30
20:00:16.000000000 +0200
@@ -49,8 +49,6 @@
 #include "hcp_if.h"
 #include "hipz_fns.h"

-extern int ehca_debug_level;
-
 static inline int ehca_write_rwqe(struct ipz_queue *ipz_rqueue,
                          struct ehca_wqe *wqe_p,
                          struct ib_recv_wr *recv_wr)
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ehca_sqp.c
infiniband_work/drivers/infiniband/hw/ehca/ehca_sqp.c
--- infiniband/drivers/infiniband/hw/ehca/ehca_sqp.c  2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_sqp.c   2006-08-30
20:00:16.000000000 +0200
@@ -49,8 +49,6 @@
 #include "hcp_if.h"


-extern int ehca_port_act_time;
-
 /**
  * ehca_define_sqp - Defines special queue pair 1 (GSI QP). When special
queue
  * pair is created successfully, the corresponding port gets active.
diff -Nurp infiniband/drivers/infiniband/hw/ehca/hcp_if.c
infiniband_work/drivers/infiniband/hw/ehca/hcp_if.c
--- infiniband/drivers/infiniband/hw/ehca/hcp_if.c    2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/hcp_if.c     2006-08-30
20:00:17.000000000 +0200
@@ -410,7 +410,6 @@ u64 hipz_h_query_port(const struct ipz_a
                  const u8 port_id,
                  struct hipz_query_port *query_port_response_block)
 {
-     extern int ehca_debug_level;
      u64 ret;
      u64 dummy;
      u64 r_cb = virt_to_abs(query_port_response_block);
diff -Nurp infiniband/drivers/infiniband/hw/ehca/hcp_phyp.h
infiniband_work/drivers/infiniband/hw/ehca/hcp_phyp.h
--- infiniband/drivers/infiniband/hw/ehca/hcp_phyp.h  2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/hcp_phyp.h   2006-08-30
20:00:16.000000000 +0200
@@ -69,13 +69,13 @@ struct h_galpas {
 static inline u64 hipz_galpa_load(struct h_galpa galpa, u32 offset)
 {
      u64 addr = galpa.fw_handle + offset;
-     return *(u64 *)addr;
+     return *(volatile u64 __force *)addr;
 }

 static inline void hipz_galpa_store(struct h_galpa galpa, u32 offset, u64
value)
 {
      u64 addr = galpa.fw_handle + offset;
-     *(u64 *)addr = value;
+     *(volatile u64 __force *)addr = value;
 }

 int hcp_galpas_ctor(struct h_galpas *galpas,
diff -Nurp infiniband/drivers/infiniband/hw/ehca/ipz_pt_fn.c
infiniband_work/drivers/infiniband/hw/ehca/ipz_pt_fn.c
--- infiniband/drivers/infiniband/hw/ehca/ipz_pt_fn.c 2006-08-30
18:02:01.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ipz_pt_fn.c  2006-08-30
20:00:16.000000000 +0200
@@ -41,8 +41,6 @@
 #include "ehca_tools.h"
 #include "ipz_pt_fn.h"

-extern int ehca_hwlevel;
-
 void *ipz_qpageit_get_inc(struct ipz_queue *queue)
 {
      void *ret = ipz_qeit_get(queue);

