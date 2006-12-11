Return-Path: <linux-kernel-owner+w=401wt.eu-S1762972AbWLKRvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762972AbWLKRvR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762986AbWLKRvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:51:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:44057 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762972AbWLKRvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:51:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e/H+qojwAtZy8PG5mapu0eSNguByLGtbn0iOI4772SxIRTR0ygTTMbPa49TfMZiZb48kOjFHlw1yyD66bi6QaN/Gry1gEW6xcl5zGyxMQWv6e3nQDBm7M85zpFcupw2SlJbgnqWHAR0vQUq6yktiYrDFfoEHSK0vGPykU1SJh9s=
Message-ID: <3f250c710612110951gd870234sf13f2d721866cd7e@mail.gmail.com>
Date: Mon, 11 Dec 2006 13:51:12 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] kobject: kobject_uevent() returns manageable value
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <11658546092095-git-send-email-aneesh.kumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11658546092095-git-send-email-aneesh.kumar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aneesh,

The patch update sounds good.

BR,

Mauricio Lin.

On 12/11/06, Aneesh Kumar K.V <aneesh.kumar@gmail.com> wrote:
> Since kobject_uevent() function does not return an integer value to
> indicate if its operation was completed with success or not, it is
> worth changing it in order to report a proper status (success or
> error) instead of returning void.
>
> CC: Mauricio Lin <mauriciolin@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> ---
>  include/linux/kobject.h |    8 ++++----
>  lib/kobject_uevent.c    |   44 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index d1c8d28..fc93c53 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -265,8 +265,8 @@ extern int __must_check subsys_create_file(struct subsystem * ,
>                                         struct subsys_attribute *);
>
>  #if defined(CONFIG_HOTPLUG)
> -void kobject_uevent(struct kobject *kobj, enum kobject_action action);
> -void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
> +int kobject_uevent(struct kobject *kobj, enum kobject_action action);
> +int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>                         char *envp[]);
>
>  int add_uevent_var(char **envp, int num_envp, int *cur_index,
> @@ -274,8 +274,8 @@ int add_uevent_var(char **envp, int num_envp, int *cur_index,
>                         const char *format, ...)
>         __attribute__((format (printf, 7, 8)));
>  #else
> -static inline void kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
> -static inline void kobject_uevent_env(struct kobject *kobj,
> +static inline int kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
> +static inline int kobject_uevent_env(struct kobject *kobj,
>                                       enum kobject_action action,
>                                       char *envp[])
>  { }
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index a192276..84272ed 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -63,8 +63,11 @@ static char *action_to_string(enum kobject_action action)
>   * @action: action that is happening (usually KOBJ_MOVE)
>   * @kobj: struct kobject that the action is happening to
>   * @envp_ext: pointer to environmental data
> + *
> + * Returns 0 if kobject_uevent() is completed with success or the
> + * corresponding error when it fails.
>   */
> -void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
> +int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>                         char *envp_ext[])
>  {
>         char **envp;
> @@ -79,14 +82,16 @@ void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>         u64 seq;
>         char *seq_buff;
>         int i = 0;
> -       int retval;
> +       int retval = 0;
>         int j;
>
>         pr_debug("%s\n", __FUNCTION__);
>
>         action_string = action_to_string(action);
> -       if (!action_string)
> -               return;
> +       if (!action_string) {
> +               pr_debug("kobject attempted to send uevent without action_string!\n");
> +               return -EINVAL;
> +       }
>
>         /* search the kset we belong to */
>         top_kobj = kobj;
> @@ -95,31 +100,39 @@ void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
>                         top_kobj = top_kobj->parent;
>                 } while (!top_kobj->kset && top_kobj->parent);
>         }
> -       if (!top_kobj->kset)
> -               return;
> +       if (!top_kobj->kset) {
> +               pr_debug("kobject attempted to send uevent without kset!\n");
> +               return -EINVAL;
> +       }
>
>         kset = top_kobj->kset;
>         uevent_ops = kset->uevent_ops;
>
>         /*  skip the event, if the filter returns zero. */
>         if (uevent_ops && uevent_ops->filter)
> -               if (!uevent_ops->filter(kset, kobj))
> -                       return;
> +               if (!uevent_ops->filter(kset, kobj)) {
> +                       pr_debug("kobject filter function caused the event to drop!\n");
> +                       return 0;
> +               }
>
>         /* environment index */
>         envp = kzalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
>         if (!envp)
> -               return;
> +               return -ENOMEM;
>
>         /* environment values */
>         buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
> -       if (!buffer)
> +       if (!buffer) {
> +               retval = -ENOMEM;
>                 goto exit;
> +       }
>
>         /* complete object path */
>         devpath = kobject_get_path(kobj, GFP_KERNEL);
> -       if (!devpath)
> +       if (!devpath) {
> +               retval = -ENOENT;
>                 goto exit;
> +       }
>
>         /* originating subsystem */
>         if (uevent_ops && uevent_ops->name)
> @@ -204,7 +217,7 @@ exit:
>         kfree(devpath);
>         kfree(buffer);
>         kfree(envp);
> -       return;
> +       return retval;
>  }
>
>  EXPORT_SYMBOL_GPL(kobject_uevent_env);
> @@ -214,10 +227,13 @@ EXPORT_SYMBOL_GPL(kobject_uevent_env);
>   *
>   * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
>   * @kobj: struct kobject that the action is happening to
> + *
> + * Returns 0 if kobject_uevent() is completed with success or the
> + * corresponding error when it fails.
>   */
> -void kobject_uevent(struct kobject *kobj, enum kobject_action action)
> +int kobject_uevent(struct kobject *kobj, enum kobject_action action)
>  {
> -       kobject_uevent_env(kobj, action, NULL);
> +       return kobject_uevent_env(kobj, action, NULL);
>  }
>
>  EXPORT_SYMBOL_GPL(kobject_uevent);
> --
> 1.4.4.2.gdb98-dirty
>
>
