Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVH3X2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVH3X2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbVH3X2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:28:54 -0400
Received: from smtp.istop.com ([66.11.167.126]:38598 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751387AbVH3X2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:28:54 -0400
From: Daniel Phillips <phillips@istop.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4 of 4] Configfs is really sysfs
Date: Tue, 30 Aug 2005 19:30:41 -0400
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       Greg KH <greg@kroah.com>
References: <200508310854.40482.phillips@istop.com> <200508310859.55746.phillips@istop.com> <200508310903.10197.phillips@istop.com>
In-Reply-To: <200508310903.10197.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301930.41187.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(without kmail bugs this time)

A kernel code example that uses the modified configfs to define a simple
configuration interface.  Note the use of kobjects and ksets instead of
config_items and config_groups.

Also notice how much code is required to get a simple value from
userspace to kernel space.  This is a big problem that needs to be
addressed soon, before we end up with tens or hundreds of thousands of
lines of code code bloat just to get and set variables from user space.

Regards,

Daniel

#include <linux/init.h>
#include <linux/module.h>
#include <linux/slab.h>

#include <linux/configfs.h>

struct ddbond_info {
 struct kobject item;
 int controlsock;
};

static inline struct ddbond_info *to_ddbond_info(struct kobject *item)
{
 return container_of(item, struct ddbond_info, item);
}

static ssize_t ddbond_info_attr_show(struct kobject *item,
 struct attribute *attr, char *page)
{
 ssize_t count;
 struct ddbond_info *ddbond_info = to_ddbond_info(item);
 count = sprintf(page, "%d\n", ddbond_info->controlsock);
 return count;
}

static ssize_t ddbond_info_attr_store(struct kobject *item,
 struct attribute *attr, const char *page, size_t count)
{
 struct ddbond_info *ddbond_info = to_ddbond_info(item);
 unsigned long tmp;
 char *p = (char *)page;

 tmp = simple_strtoul(p, &p, 10);
 if (!p || (*p && (*p != '\n')))
  return -EINVAL;
 if (tmp > INT_MAX)
  return -ERANGE;
 ddbond_info->controlsock = tmp;
 return count;
}

static void ddbond_info_release(struct kobject *item)
{
 kfree(to_ddbond_info(item));
}

static struct kobj_type ddbond_info_type = {
 .sysfs_ops = &(struct sysfs_ops){
  .show = ddbond_info_attr_show,
  .store = ddbond_info_attr_store,
  .release = ddbond_info_release,
 },
 .default_attrs = (struct attribute *[]){
  &(struct attribute){
   .owner = THIS_MODULE,
   .name = "sockname",
   .mode = S_IRUGO | S_IWUSR,
  },
  NULL,
 },
 .ct_owner = THIS_MODULE,
};

static struct kobject *ddbond_make_item(struct kset *group, const char *name)
{
 struct ddbond_info *ddbond_info;
 if (!(ddbond_info = kcalloc(1, sizeof(struct ddbond_info), GFP_KERNEL)))
  return NULL;
 kobject_init_type_name(&ddbond_info->item, name, &ddbond_info_type);
 return &ddbond_info->item;
}

static ssize_t ddbond_description(struct kobject *item,
 struct attribute *attr, char *page)
{
 return sprintf(page,
  "A ddbond block server has two components: a userspace server and a kernel\n"
  "io daemon.  First start the server and give it the name of a socket it will\n"
  "create, then create a ddbond directory and write the same name into the\n"
  "socket attribute\n");
}

static struct kobj_type ddbond_type = {
 .sysfs_ops = &(struct sysfs_ops){
  .show = ddbond_description,
 },
 .ct_group_ops = &(struct configfs_group_operations){
  .make_item = ddbond_make_item,
 },
 .default_attrs = (struct attribute *[]){
  &(struct attribute){
   .owner = THIS_MODULE,
   .name = "description",
   .mode = S_IRUGO,
  },
  NULL,
 }
};

static struct subsystem ddbond_subsys = {
 .kset = {
  .kobj = {
   .k_name = "ddbond",
   .ktype = &ddbond_type,
  },
 },
};

static int __init init_ddbond_config(void)
{
 int ret;
 config_group_init(&ddbond_subsys.kset);
 init_rwsem(&ddbond_subsys.rwsem);
 if ((ret = configfs_register_subsystem(&ddbond_subsys)))
  printk(KERN_ERR "Error %d while registering subsystem %s\n",
         ret, ddbond_subsys.kset.kobj.k_name);
 return ret;
}

static void __exit exit_ddbond_config(void)
{
 configfs_unregister_subsystem(&ddbond_subsys);
}

module_init(init_ddbond_config);
module_exit(exit_ddbond_config);
MODULE_LICENSE("GPL");
