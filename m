Return-Path: <linux-kernel-owner+w=401wt.eu-S1425621AbWLHQvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425621AbWLHQvO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425628AbWLHQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:51:14 -0500
Received: from smtp-out.google.com ([216.239.33.17]:63254 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425621AbWLHQvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:51:13 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ozZqOeM9xQGK/6GnX2OGzxeCYDwaQtt22GMxuhH//Or+jI5EznGaBoz5Zl69zWNnt
	IbXcoiCdc2D/gm7yLakng==
Message-ID: <6599ad830612080851q55fe8c95m9f00a2a9a3779dc4@mail.gmail.com>
Date: Fri, 8 Dec 2006 08:51:01 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [PATCH] cpuset - rework cpuset_zone_allowed api
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andi Kleen" <ak@suse.de>,
       "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <20061208112152.12631.67436.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061208112152.12631.67436.sendpatchset@jackhammer.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/06, Paul Jackson <pj@sgi.com> wrote:
>
> -int __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
> +int __cpuset_zone_allowed_softwall(struct zone *z, gfp_t gfp_mask)
>  {
>         int node;                       /* node that zone z is on */
>         const struct cpuset *cs;        /* current cpuset ancestors */
> @@ -2335,6 +2351,40 @@ int __cpuset_zone_allowed(struct zone *z
>         return allowed;
>  }

While you're changing this, is there a good reason not to check
is_mem_exclusive() *before* taking callback_mutex and calling
nearest_exclusive_ancestor()?

something like:

rcu_read_lock();
exc = is_mem_exclusive(rcu_dereference(current->cs));
rcu_read_unlock();
if (exc)
  return 1;

... take callback_mutex, etc ...

Paul
