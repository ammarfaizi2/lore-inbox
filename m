Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWAMSMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWAMSMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbWAMSMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:12:50 -0500
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:15018 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1422788AbWAMSMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:12:49 -0500
Message-ID: <43C7EDCF.3050402@kolumbus.fi>
Date: Fri, 13 Jan 2006 20:13:35 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG: gfp_zone() not mapping zone modifiers correctly
 and bad ordering of fallback lists
References: <20060113155026.GA4811@skynet.ie>
In-Reply-To: <20060113155026.GA4811@skynet.ie>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2|September 12, 2005) at 13.01.2006 20:12:40,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 13.01.2006 20:12:40,
	Serialize complete at 13.01.2006 20:12:40,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 13.01.2006 20:13:41,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 13.01.2006 20:13:43,
	Serialize complete at 13.01.2006 20:13:43
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:

>Hi Andrew,
>
>This patch is divided into two parts and addresses a bug in how zone
>fallback lists are calculated and how __GFP_* zone modifiers are mapped to
>their equivilant ZONE_* type. It applies to 2.6.15-mm3 and has been tested
>on x86 and ppc64. It has been reported by Yasunori Goto that it boots on
>ia64. Details as follows;
>
>build_zonelists() attempts to be smart, and uses highest_zone() so that it
>doesn't attempt to call build_zonelists_node() for empty zones.  However,
>build_zonelists_node() is smart enough to do the right thing by itself and
>build_zonelists() already has the zone index that highest_zone() is meant
>to provide. So, remove the unnecessary function highest_zone().
>
>The helper function gfp_zone() assumes that the bits used in the zone modifier
>of a GFP flag maps directory on to their ZONE_* equivalent and just applies a
>mask. However, the bits do not map directly and the wrong fallback lists can
>be used. If unluckly, the system can go OOM when plenty of suitable memory
>is available. This patch redefines the __GFP_ zone modifier flags to allow
>a simple mapping to their equivilant ZONE_ type.
>
>  
>
What's the exact failure case? Afaik, we loop though all the 
GFP_ZONETYPES, building the appropriate zone lists at 0 - 
GFP_ZONETYPES-1 indexes. So the direct GFP -> ZONE mapping should do the 
right thing.

--Mika

