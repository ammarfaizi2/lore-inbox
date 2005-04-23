Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVDWRhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVDWRhv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 13:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVDWRhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 13:37:51 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:24741 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261631AbVDWRh1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 13:37:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M4otFObVix3tag8fn6m0aqjssvEH1CiZUVn79+cILqGvDWnJ5QosTy5/M696H9lAW6a2Kece3gWjLbd01m5WG1FT93mYYOeZHqUtIa0JPBWhtPZqRLafsnY4WaniHg3ijfnZwZ5vqDABtzSNUCNQ2g50WqoPGI0Dc74fODYLq2Y=
Message-ID: <2a4f155d05042310375d99994b@mail.gmail.com>
Date: Sat, 23 Apr 2005 20:37:23 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: gcc-4.0.0 final miscompiles net/ipv4/devinet.c:devinet_sysctl_register()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200504230952.j3N9qm6W012596@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504230952.j3N9qm6W012596@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whats the bugzilla # for this so others can track it?


On 4/23/05, Mikael Pettersson <mikpe@csd.uu.se> wrote:
> gcc-4.0.0 miscompiles a pointer subtraction operation in
> net/ipv4/devinet.c, resulting in oopses from /sbin/sysctl.
> 
> Below is a copy of the test case I just sent to gcc bugzilla.
> 
> /Mikael
> 
> /* gcc4pointersubtractionbug.c
>  * Written by Mikael Pettersson, mikpe@csd.uu.se, 2005-04-23.
>  *
>  * This program illustrates a code optimisation bug in
>  * gcc-4.0.0 (final) and gcc-4.0.0-20050417, where a pointer
>  * subtraction operation is compiled as a pointer addition.
>  * Observed at -O2. gcc was configured for i686-pc-linux-gnu.
>  *
>  * This bug broke net/ipv4/devinet.c:devinet_sysctl_register()
>  * in the linux-2.6.12-rc2 Linux kernel, causing /sbin/sysctl
>  * to trigger kernel oopses.
>  *
>  * gcc-4.0.0-20050416 and earlier prereleases do not have this bug.
>  */
> #include <stdio.h>
> #include <string.h>
> 
> #define NRVARS	5
> 
> struct ipv4_devconf {
>     int var[NRVARS];
> };
> struct ipv4_devconf ipv4_devconf[2];
> 
> struct ctl_table {
>     void *data;
> };
> 
> struct devinet_sysctl_table {
>     struct ctl_table devinet_vars[NRVARS];
> };
> 
> void devinet_sysctl_relocate(struct devinet_sysctl_table *t,
> 			     struct ipv4_devconf *p)
> {
>     int i;
> 
>     for (i = 0; i < NRVARS; i++)
> 	/* Initially data points to a field in ipv4_devconf[0].
> 	   This code relocates it to the corresponding field in *p.
> 	   At -O2, gcc-4.0.0-20050417 and gcc-4.0.0 (final)
> 	   miscompile this pointer subtraction as a pointer addition. */
> 	t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf[0];
> }
> 
> struct devinet_sysctl_table devinet_sysctl;
> 
> int main(void)
> {
>     struct devinet_sysctl_table t;
>     int i;
> 
>     for(i = 0; i < NRVARS; i++)
> 	devinet_sysctl.devinet_vars[i].data = &ipv4_devconf[0].var[i];
> 
>     memcpy(&t, &devinet_sysctl, sizeof t);
>     devinet_sysctl_relocate(&t, &ipv4_devconf[1]);
> 
>     for(i = 0; i < NRVARS; i++)
> 	if (t.devinet_vars[i].data != &ipv4_devconf[1].var[i]) {
> 	    fprintf(stderr, "t.devinet_vars[%u].data == %p, should be %p\n",
> 		    i,
> 		    t.devinet_vars[i].data,
> 		    &ipv4_devconf[1].var[i]);
> 	    return 1;
> 	}
> 
>     printf("all ok\n");
>     return 0;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Time is what you make of it
