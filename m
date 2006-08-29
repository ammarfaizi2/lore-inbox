Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWH2UN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWH2UN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWH2UN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:13:26 -0400
Received: from kanga.kvack.org ([66.96.29.28]:39917 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751445AbWH2UN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:13:26 -0400
Date: Tue, 29 Aug 2006 16:13:18 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Eric Paris <eparis@parisplace.org>
Cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov,
       James Morris <jmorris@redhat.com>, akpm@osdl.org
Subject: Re: [PATCH] SELinux: work around filesystems which call d_instantiate before setting inode mode
Message-ID: <20060829201318.GN18092@kvack.org>
References: <1156882105.3195.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156882105.3195.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 04:08:25PM -0400, Eric Paris wrote:
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index 960ef18..043d479 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -125,6 +125,8 @@ int avc_add_callback(int (*callback)(u32
>  		     u32 events, u32 ssid, u32 tsid,
>  		     u16 tclass, u32 perms);
>  
> +const char *avc_class_to_string(u16 tclass);
> +
>  /* Exported to selinuxfs */
>  int avc_get_hash_stats(char *page);
>  extern unsigned int avc_cache_threshold;
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index a300702..88bba69 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -218,7 +218,7 @@ static void avc_dump_query(struct audit_
>  		audit_log_format(ab, " tcontext=%s", scontext);
>  		kfree(scontext);
>  	}
> -	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> +	audit_log_format(ab, " tclass=%s", avc_class_to_string(tclass));
>  }
>  
>  /**
> @@ -913,3 +913,15 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
>  	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
>  	return rc;
>  }
> +
> +/**
> + * avc_class_to_string - return a human readable string given an object class.
> + * @tclass: the target class we wish to translate
> + *
> + * Simply take the target object class passed to us and return the human
> + * readable string associated with that class
> + */
> +const char *avc_class_to_string(u16 tclass)
> +{
> +	return class_to_string[tclass];
> +}

This portion of the patch has absolutely nothing to do with the core 
changes, and should be separate.  It is also introducing bloat, as the 
array index is very easy to calculate.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
