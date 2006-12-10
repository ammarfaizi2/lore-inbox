Return-Path: <linux-kernel-owner+w=401wt.eu-S1762257AbWLJRE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762257AbWLJRE3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762259AbWLJRE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:04:29 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:25892 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762257AbWLJRE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:04:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=O8EX2VggDyzDtvbSYTkxlzpDQnNz4sXEhdGZgIIkKReh1XS2olUGsB343BVLj31xqnp6/XnQh11g1/phGsU8IjJYBKCVVXV9mHJWLKKzG8TFyamL9UXD/zaZ0O8e3oYLgiloWKXWEUggC96bgyMHRGEp8+DJxQD2GIpLmLGJors=
Message-ID: <457C3E11.8050401@gmail.com>
Date: Sun, 10 Dec 2006 22:34:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
CC: kernelnewbies@nl.linux.org
Subject: Re: kobject_uevent() question
References: <20061128161218.43358.qmail@web51813.mail.yahoo.com> <90539.55300.qm@web51815.mail.yahoo.com> <20061128195532.GA13705@kroah.com>
In-Reply-To: <20061128195532.GA13705@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------080800040501050602070307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080800040501050602070307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Tue, Nov 28, 2006 at 07:38:01PM +0000, Mauricio Lin wrote:
>> Hi Greg,
>>
>> It is working now. The failure was in the kobject_uevent() function. As
>> the kset of my kobject was not set properly, the kobject_uevent()
>> function just returned void.
>>
>> I wonder why the kobjec_uevent() does not return an integer to indicate
>> if the operation was completed with success or not.
> 
> Feel free to send patches fixing this issue :)
> 
> thanks,
> 
> 

Something like this ?

-aneesh

--------------080800040501050602070307
Content-Type: text/x-patch;
 name="kobject_uevent.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kobject_uevent.diff"

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index d1c8d28..fc93c53 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -265,8 +265,8 @@ extern int __must_check subsys_create_file(struct subsystem * ,
 					struct subsys_attribute *);
 
 #if defined(CONFIG_HOTPLUG)
-void kobject_uevent(struct kobject *kobj, enum kobject_action action);
-void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
+int kobject_uevent(struct kobject *kobj, enum kobject_action action);
+int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 			char *envp[]);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
@@ -274,8 +274,8 @@ int add_uevent_var(char **envp, int num_envp, int *cur_index,
 			const char *format, ...)
 	__attribute__((format (printf, 7, 8)));
 #else
-static inline void kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
-static inline void kobject_uevent_env(struct kobject *kobj,
+static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
+static inline int kobject_uevent_env(struct kobject *kobj,
 				      enum kobject_action action,
 				      char *envp[])
 { }
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index a192276..7eaf6f6 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -64,7 +64,7 @@ static char *action_to_string(enum kobject_action action)
  * @kobj: struct kobject that the action is happening to
  * @envp_ext: pointer to environmental data
  */
-void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
+int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 			char *envp_ext[])
 {
 	char **envp;
@@ -79,14 +79,16 @@ void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	u64 seq;
 	char *seq_buff;
 	int i = 0;
-	int retval;
+	int retval = 0;
 	int j;
 
 	pr_debug("%s\n", __FUNCTION__);
 
 	action_string = action_to_string(action);
-	if (!action_string)
-		return;
+	if (!action_string) {
+		pr_debug("kobject attempted to send uevent without action_string!\n");
+		return -EINVAL;
+	}
 
 	/* search the kset we belong to */
 	top_kobj = kobj;
@@ -95,31 +97,39 @@ void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 			top_kobj = top_kobj->parent;
 		} while (!top_kobj->kset && top_kobj->parent);
 	}
-	if (!top_kobj->kset)
-		return;
+	if (!top_kobj->kset) {
+		pr_debug("kobject attempted to send uevent without kset!\n");
+		return -EINVAL;
+	}
 
 	kset = top_kobj->kset;
 	uevent_ops = kset->uevent_ops;
 
 	/*  skip the event, if the filter returns zero. */
 	if (uevent_ops && uevent_ops->filter)
-		if (!uevent_ops->filter(kset, kobj))
-			return;
+		if (!uevent_ops->filter(kset, kobj)) {
+			pr_debug("kobject filter function caused the event to drop!\n");
+			return 0;
+		}
 
 	/* environment index */
 	envp = kzalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
-		return;
+		return -ENOMEM;
 
 	/* environment values */
 	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
-	if (!buffer)
+	if (!buffer) {
+		retval = -ENOMEM;
 		goto exit;
+	}
 
 	/* complete object path */
 	devpath = kobject_get_path(kobj, GFP_KERNEL);
-	if (!devpath)
+	if (!devpath) {
+		retval = -ENOENT;
 		goto exit;
+	}
 
 	/* originating subsystem */
 	if (uevent_ops && uevent_ops->name)
@@ -204,7 +214,7 @@ exit:
 	kfree(devpath);
 	kfree(buffer);
 	kfree(envp);
-	return;
+	return retval;
 }
 
 EXPORT_SYMBOL_GPL(kobject_uevent_env);
@@ -215,9 +225,9 @@ EXPORT_SYMBOL_GPL(kobject_uevent_env);
  * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
  * @kobj: struct kobject that the action is happening to
  */
-void kobject_uevent(struct kobject *kobj, enum kobject_action action)
+int kobject_uevent(struct kobject *kobj, enum kobject_action action)
 {
-	kobject_uevent_env(kobj, action, NULL);
+	return kobject_uevent_env(kobj, action, NULL);
 }
 
 EXPORT_SYMBOL_GPL(kobject_uevent);

--------------080800040501050602070307--
