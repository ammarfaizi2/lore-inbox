Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSKHMSn>; Fri, 8 Nov 2002 07:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSKHMSn>; Fri, 8 Nov 2002 07:18:43 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:58554 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261689AbSKHMSl>;
	Fri, 8 Nov 2002 07:18:41 -0500
Date: Fri, 8 Nov 2002 13:25:23 +0100
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>, mdiehl@dominion.dyndns.org,
       linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [documentation] Re: [LARTC] IPSEC FIRST LIGHT! (by non-kernel developer :-))
Message-ID: <20021108122523.GA21075@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, mdiehl@dominion.dyndns.org,
	linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
References: <20021107130244.GA25032@outpost.ds9a.nl> <20021108023926.51B985606@dominion.dyndns.org> <20021108094122.GB16512@outpost.ds9a.nl> <20021108.015230.94737520.davem@redhat.com> <20021108111529.GA19850@outpost.ds9a.nl> <20021108112715.GA20226@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108112715.GA20226@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:27:15PM +0100, bert hubert wrote:
> On Fri, Nov 08, 2002 at 12:15:29PM +0100, bert hubert wrote:
> 
> > This code locks up solid on any ipsec TCP traffic outgoing with this
> > configuration:

Bug is here:

+/* Optimize later using cookies and generation ids. */
+
 static struct dst_entry *xfrm4_dst_check(struct dst_entry *dst, u32 cookie)
 {
-       dst_release(dst);
-       return NULL;
+       struct dst_entry *child = dst;
+
+       while (child) {
+               if (child->obsolete > 0 ||
+                   (child->xfrm && child->xfrm->km.state != XFRM_STATE_VALID)) {
+                       dst_release(dst);
+                       return NULL;
+               }
+       }
+
+       return dst;
 }


Kernel enters a very tight loop here, I'm amazed that magic sysrq still
works, how is that?

Anyhow, this function smells but I'm not sure how it should be fixed,
perhaps child=child->next?

Regards,

bert


> 
> Also with the following configuration:
> 
> add 10.0.0.216 10.0.0.12 ah 24500 -A hmac-md5 "1234567890123456";
> spdadd 10.0.0.216 10.0.0.11 any -P out ipsec
>             ah/transport//require;
> 
> -or-
> 
> add 10.0.0.216 10.0.0.12 esp 24501 -E 3des-cbc "123456789012123456789012";
> spdadd 10.0.0.216 10.0.0.11 any -P out ipsec
>             esp/transport//require;
>  
> 10.0.0.12 is a host which does not exist. 'telnet 10.0.0.12' locks up
> instantly. I'm unsure how to extract more data from my kernel.
> 
> Regards,
> 
> bert
> 
> -- 
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
