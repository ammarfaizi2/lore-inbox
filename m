Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbUKDSzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUKDSzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbUKDSzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:55:35 -0500
Received: from [62.206.217.67] ([62.206.217.67]:986 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262310AbUKDSzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:55:19 -0500
Message-ID: <418A7B0B.7040803@trash.net>
Date: Thu, 04 Nov 2004 19:55:07 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks
 amanda dumps
References: <20041104121522.GA16547@merlin.emma.line.org>
In-Reply-To: <20041104121522.GA16547@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>You can use "bk receive" to patch with this mail.
>
>BK: Parent repository is bk://linux.bkbits.net/linux-2.5
>
>Patch description:
>ChangeSet@1.2427, 2004-11-04 13:00:54+01:00, matthias.andree@gmx.de
>    Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps.
>  
>    Fix a bug where the ip_conntrack_amanda module replaces the first LF
>    after "CONNECT " by a NUL byte. This causes the UDP checksum to become
>    corrupt and strips off the OPTIONS argument from the received packet,
>    breaking amanda's sendbackup component altogether.  Replace the LF
>    character before releasing the buffer.
>  
>
The data that is changed is only a copy, the actual packet is not touched.

Regards
Patrick

>  
>    Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
>
>Matthias Andree
>
>------------------------------------------------------------------------
>
>##### DIFFSTAT #####
> ip_conntrack_amanda.c |   12 ++++++++----
> 1 files changed, 8 insertions(+), 4 deletions(-)
>
>##### GNUPATCH #####
>--- 1.10/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-08-19 02:14:53 +02:00
>+++ 1.11/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-11-04 12:59:26 +01:00
>@@ -49,7 +49,7 @@
> {
> 	struct ip_conntrack_expect *exp;
> 	struct ip_ct_amanda_expect *exp_amanda_info;
>-	char *amp, *data, *data_limit, *tmp;
>+	char *amp, *data, *data_limit, *tmp, *le = 0;
> 	unsigned int dataoff, i;
> 	u_int16_t port, len;
> 
>@@ -83,9 +83,10 @@
> 		goto out;
> 	data += strlen("CONNECT ");
> 
>-	/* Only search first line. */	
>-	if ((tmp = strchr(data, '\n')))
>-		*tmp = '\0';
>+	/* Only search first line.
>+	 * NB: The change to the data must be reverted later! */
>+	if ((le = strchr(data, '\n')))
>+		*le = '\0';
> 
> 	for (i = 0; i < ARRAY_SIZE(conns); i++) {
> 		char *match = strstr(data, conns[i]);
>@@ -120,6 +121,9 @@
> 	}
> 
> out:
>+	/* replace LF character to repair the packet */
>+	if (le)
>+	    *le = '\n';
> 	UNLOCK_BH(&amanda_buffer_lock);
> 	return NF_ACCEPT;
> }
>
>  
>

