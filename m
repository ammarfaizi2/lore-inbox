Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965361AbWH2VAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965361AbWH2VAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965362AbWH2VAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:00:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20118 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965361AbWH2VAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:00:45 -0400
Subject: Re: [PATCH] SELinux: work around filesystems which call
	d_instantiate before setting inode mode
From: Eric Paris <eparis@parisplace.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov,
       James Morris <jmorris@redhat.com>, akpm@osdl.org
In-Reply-To: <20060829201318.GN18092@kvack.org>
References: <1156882105.3195.4.camel@localhost.localdomain>
	 <20060829201318.GN18092@kvack.org>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 17:02:13 -0400
Message-Id: <1156885333.3195.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 16:13 -0400, Benjamin LaHaise wrote:
> On Tue, Aug 29, 2006 at 04:08:25PM -0400, Eric Paris wrote:
> > diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> > index 960ef18..043d479 100644
> > --- a/security/selinux/include/avc.h
> > +++ b/security/selinux/include/avc.h
> > @@ -125,6 +125,8 @@ int avc_add_callback(int (*callback)(u32
> >  		     u32 events, u32 ssid, u32 tsid,
> >  		     u16 tclass, u32 perms);
> >  
> > +const char *avc_class_to_string(u16 tclass);
> > +
> >  /* Exported to selinuxfs */
> >  int avc_get_hash_stats(char *page);
> >  extern unsigned int avc_cache_threshold;
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index a300702..88bba69 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -218,7 +218,7 @@ static void avc_dump_query(struct audit_
> >  		audit_log_format(ab, " tcontext=%s", scontext);
> >  		kfree(scontext);
> >  	}
> > -	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> > +	audit_log_format(ab, " tclass=%s", avc_class_to_string(tclass));
> >  }
> >  
> >  /**
> > @@ -913,3 +913,15 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
> >  	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
> >  	return rc;
> >  }
> > +
> > +/**
> > + * avc_class_to_string - return a human readable string given an object class.
> > + * @tclass: the target class we wish to translate
> > + *
> > + * Simply take the target object class passed to us and return the human
> > + * readable string associated with that class
> > + */
> > +const char *avc_class_to_string(u16 tclass)
> > +{
> > +	return class_to_string[tclass];
> > +}
> 
> This portion of the patch has absolutely nothing to do with the core 
> changes, and should be separate.  It is also introducing bloat, as the 
> array index is very easy to calculate.
> 
> 		-ben

We need some method to get access to the class_to_string array (defined
inside avc.c) from hooks.c  In my core changes this is needed to be able
to translate the numeric tclass into a human readable string in the new
warning message in hooks.c  I agree this would be needless if the only
user of avc_class_to_string was avc_dump_query but the whole point of
adding this new accessor was the new inode_update_sclass user in
hooks.c.

Were you suggesting that rather than use an accessor function I instead
make the array extern and use it directly?  I don't forsee this array
syntax changing any time in the future but I'd still rather have some
logical interface that is most likely just going to get compiled out.
This way if things do change we don't have to hunt down all the direct
users of the array across different code.

-Eric

