Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTLRCSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 21:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbTLRCSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 21:18:41 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:2979 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264898AbTLRCSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 21:18:39 -0500
Message-ID: <3FE10F8A.7080902@us.ltcfwd.linux.ibm.com>
Date: Wed, 17 Dec 2003 20:23:06 -0600
From: Linda Xie <lxiep@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linda Xie <lxiep@us.ibm.com>, linux-kernel@vger.kernel.org,
       scheel@us.ibm.com, wortman@us.ibm.com
Subject: Re: PATCPATCH -- add unlimited name lengths support to sysfs
References: <3FDF902A.4000903@us.ltcfwd.linux.ibm.com> <20031216231447.GA4781@kroah.com> <3FE0BC4D.8080605@us.ltcfwd.linux.ibm.com> <20031217204100.GA13305@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Dec 17, 2003 at 02:27:57PM -0600, Linda Xie wrote:
> 
>>Greg KH wrote:
>>
>>>On Tue, Dec 16, 2003 at 05:07:22PM -0600, Linda Xie wrote:
>>>
>>>
>>>>diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
>>>>--- a/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
>>>>+++ b/fs/sysfs/symlink.c	Sun Dec 14 21:19:29 2003
>>>>@@ -42,7 +42,10 @@
>>>>	struct kobject * p = kobj;
>>>>	int length = 1;
>>>>	do {
>>>>-		length += strlen(p->name) + 1;
>>>>+		if (p->k_name)
>>>>+			length += strlen(p->k_name) + 1;
>>>>+		else
>>>>+			length += strlen(p->name) + 1;
>>>
>>>
>>>Shouldn't this just be:
>>>		length += strlen(kobject_name(p)) + 1;
>>>
>>
>>That is correct. But here is my concern: Some of the callers of 
>>sysfs_create_link()
>>set p->name instead of p->k_name. So for them, the length calculated 
>>using kobject_name(p) will be incorrect. Correct me if I am wrong.
> 
> 
> Well if a kobject only uses the .name field, .k_name will point to it
> (see kobject_add()), so the kobject_name() call will work in the above
> case (as it should always do.)  Actually that if (p->k_name) statement
> will always be true because of this fact :)
> 
> This lets people like the edd driver which does:
> 	 snprintf(edev->kobj.name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x", edd[i].device);
> still work properly.  Ideally, callers like this should change to use
> the kobject_set_name() function, but there's no rush.
> 
> thanks,
> 
> greg k-h
> 

Thank you very much. Below is an updated patch:


diff -Nru a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c        Wed Dec 17 20:08:01 2003
+++ b/fs/sysfs/symlink.c        Wed Dec 17 20:08:01 2003
@@ -42,7 +42,7 @@
         struct kobject * p = kobj;
         int length = 1;
         do {
-               length += strlen(p->name) + 1;
+               length += strlen(kobject_name(p)) + 1;
                 p = p->parent;
         } while (p);
         return length;
@@ -54,11 +54,11 @@

         --length;
         for (p = kobj; p; p = p->parent) {
-               int cur = strlen(p->name);
+               int cur = strlen(kobject_name(p));

                 /* back up enough to print this bus id with '/' */
                 length -= cur;
-               strncpy(buffer + length,p->name,cur);
+               strncpy(buffer + length,kobject_name(p),cur);
                 *(buffer + --length) = '/';
         }


Linda




