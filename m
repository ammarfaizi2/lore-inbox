Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWGFXMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWGFXMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWGFXMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:12:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750711AbWGFXMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:12:03 -0400
Date: Thu, 6 Jul 2006 16:05:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: nagar@watson.ibm.com, jlan@sgi.com, pj@sgi.com, Valdis.Kletnieks@vt.edu,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control
 exit data through cpumasks]
Message-Id: <20060706160557.6f0cdfa0.akpm@osdl.org>
In-Reply-To: <20060706224009.GA14627@postel.suug.ch>
References: <44ACD7C3.5040008@watson.ibm.com>
	<20060706025633.cd4b1c1d.akpm@osdl.org>
	<1152185865.5986.15.camel@localhost.localdomain>
	<20060706120835.GY14627@postel.suug.ch>
	<20060706144808.1dd5fadf.akpm@osdl.org>
	<20060706224009.GA14627@postel.suug.ch>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf <tgraf@suug.ch> wrote:
>
> * Andrew Morton <akpm@osdl.org> 2006-07-06 14:48
> > In the interests of keeping this work decoupled from netlink enhancements
> > I'd propose the below.  Is it bad to modify the data at nla_data()?
> 
> Yes, it points into a skb data buffer which may be shared by sitting
> on other queues if the message is to be broadcasted. In this case it
> would be harmless but the policy is to leave it unmodified.

Yup, sleazy-but-safe.

> 
> > --- a/kernel/taskstats.c~per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix
> > +++ a/kernel/taskstats.c
> > @@ -299,6 +299,23 @@ cleanup:
> >  	return 0;
> >  }
> >  
> > +static int parse(struct nlattr *na, cpumask_t *mask)
> > +{
> > +	char *data;
> > +	int len;
> > +
> > +	if (na == NULL)
> > +		return 1;
> > +	len = nla_len(na);
> > +	if (len > TASKSTATS_CPUMASK_MAXLEN)
> > +		return -E2BIG;
> > +	if (len < 1)
> > +		return -EINVAL;
> > +	data = nla_data(na);
> > +	data[len - 1] = '\0';
> > +	return cpulist_parse(data, *mask);
> > +}
> 
> Usually this is done by using strlcpy:

hm, nla_strlcpy() looks more complex than it needs to be.  We really need
nla_kstrndup() ;)

Oh well.  This?


diff -puN kernel/taskstats.c~per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix kernel/taskstats.c
--- a/kernel/taskstats.c~per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix
+++ a/kernel/taskstats.c
@@ -299,6 +299,28 @@ cleanup:
 	return 0;
 }
 
+static int parse(struct nlattr *na, cpumask_t *mask)
+{
+	char *data;
+	int len;
+	int ret;
+
+	if (na == NULL)
+		return 1;
+	len = nla_len(na);
+	if (len > TASKSTATS_CPUMASK_MAXLEN)
+		return -E2BIG;
+	if (len < 1)
+		return -EINVAL;
+	data = kmalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	nla_strlcpy(data, na, len);
+	ret = cpulist_parse(data, *mask);
+	kfree(data);
+	return ret;
+}
+
 static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
@@ -309,27 +331,17 @@ static int taskstats_user_cmd(struct sk_
 	struct nlattr *na;
 	cpumask_t mask;
 
-	if (info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK]) {
-		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
-		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
-			return -E2BIG;
-		rc = cpulist_parse((char *)nla_data(na), mask);
-		if (rc)
-			return rc;
-		rc = add_del_listener(info->snd_pid, &mask, REGISTER);
+	rc = parse(info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK], &mask);
+	if (rc < 0)
 		return rc;
-	}
+	if (rc == 0)
+		return add_del_listener(info->snd_pid, &mask, REGISTER);
 
-	if (info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK]) {
-		na = info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK];
-		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
-			return -E2BIG;
-		rc = cpulist_parse((char *)nla_data(na), mask);
-		if (rc)
-			return rc;
-		rc = add_del_listener(info->snd_pid, &mask, DEREGISTER);
+	rc = parse(info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK], &mask);
+	if (rc < 0)
 		return rc;
-	}
+	if (rc == 0)
+		return add_del_listener(info->snd_pid, &mask, DEREGISTER);
 
 	/*
 	 * Size includes space for nested attributes
_

