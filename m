Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbULSCkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbULSCkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 21:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULSCke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 21:40:34 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:57468 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261267AbULSCk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 21:40:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ywd2XJkqKe89+frJ6awlR4L09Lb72iFrF4JzF8+UDevEtzi7+Vx2BdWkavj0bcGAztCEhY9ynXGPQ7Vou/Ax8jvJtKwAmqksMicaVoaUsUQEPxLgax1eVOuBxRY7P4iXcDo0NtZl0V0QFy5JcqFfRLTURacLZG3nHacLMn3Rnss=
Message-ID: <29495f1d04121818403f949fdd@mail.gmail.com>
Date: Sat, 18 Dec 2004 18:40:21 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041205004557.GA2028@us.ibm.com>
	 <20041205232007.7edc4a78.akpm@osdl.org>
	 <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
	 <20041206160405.GB1271@us.ibm.com>
	 <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
	 <20041206192243.GC1435@us.ibm.com>
	 <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004 22:49:28 -0700 (MST), Zwane Mwaikambo
<zwane@arm.linux.org.uk> wrote:
> On Sat, 11 Dec 2004, Zwane Mwaikambo wrote:
> 
> > > Introduce cpu_idle_wait() on architectures requiring modification of
> > > pm_idle from modules, this will ensure that all processors have updated
> > > their cached values of pm_idle upon exit. This patch is to address the bug
> > > report at http://bugme.osdl.org/show_bug.cgi?id=1716 and replaces the
> > > current code fix which is in violation of normal RCU usage as pointed out
> > > by Stephen, Dipankar and Paul.

<snip>

> +       wmb();
> +       do {
> +               schedule_timeout(HZ);
> +               cpus_and(map, cpu_idle_map, cpu_online_map);
> +       } while (!cpus_empty(map));

<snip>

All of these schedule_timeout() calls are broken. They do not set the
state before hand and therefore will return early. Since you're not
checking for signals and there are no waitqueue events around the
code, I'm assuming you can just use ssleep(1) instead of the current
schedule_timeout() calls.

Thanks,
Nish
