Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVKATJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVKATJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVKATJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:09:05 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:17087 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751019AbVKATJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:09:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Date: Tue, 1 Nov 2005 20:07:19 +0100
User-Agent: KMail/1.8.2
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux@brodo.de
References: <200510311606.36615.rjw@sisk.pl> <200510312045.32908.rjw@sisk.pl> <20051031124216.A18213@unix-os.sc.intel.com>
In-Reply-To: <20051031124216.A18213@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511012007.19762.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of October 2005 21:42, Ashok Raj wrote:
> On Mon, Oct 31, 2005 at 08:45:32PM +0100, Rafael J. Wysocki wrote:
> > On Monday, 31 of October 2005 20:34, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > }-- snip --{
> > > > scheduling while atomic: swapper/0x00000001/1
> > > > 
> > > > Call Trace:<ffffffff8035014a>{schedule+122} <ffffffff802e2453>{cpufreq_frequency_table_target+371}
> > > >        <ffffffff8011d60c>{powernowk8_target+1916} <ffffffff802dfdb4>{__cpufreq_driver_target+116}
> > > >        <ffffffff801be269>{sysfs_new_dirent+41} <ffffffff802e097e>{cpufreq_governor_performance+62}
> > > >        <ffffffff802dec8d>{__cpufreq_governor+173} <ffffffff802df417>{__cpufreq_set_policy+551}
> > > >        <ffffffff802df5bf>{cpufreq_set_policy+79} <ffffffff802df946>{cpufreq_add_dev+806}
> > > >        <ffffffff802df540>{handle_update+0} <ffffffff802ae21a>{sysdev_driver_register+170}
> > > >        <ffffffff802df106>{cpufreq_register_driver+198} <ffffffff8010c122>{init+194}
> > > >        <ffffffff8010f556>{child_rip+8} <ffffffff8010c060>{init+0}
> > > >        <ffffffff8010f54e>{child_rip+0} 
> > > 
> > > Well I can't find it.  Ingo, didn't you have a debug patch which would help
> > > us identify where this atomic section started?
> > 
> > This is 100% reproducible on my box so I'll try to figure out what's up tomorrow
> > (unless someone else does it earlier ;-)).  Now I can only say it did not happen
> > with 2.6.14-rc5-mm1.
> 
> This could be because of the new patch, i added preempt_disable() instead
> of taking cpucontrol lock in __cpufreq_driver_target().

Yes, that's it.

> The reason is we now enter the same code path from the cpu_up() and cpu_down()
> generated cpu notifier callbacks and ends up trying to lock when the 
> call path already has the cpucontrol lock.
> 
> Its happening because we do set_cpus_allowed() in powernowk8_target().

Unfortunately, powernowk8_target() calls schedule() right after
set_cpus_allowed(), so it throws "scheduling while atomic" on every call,
because of the preempt_disable()/_enable() around it.

Greetings,
Rafael

