Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161622AbWJaENM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161622AbWJaENM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161623AbWJaENM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:13:12 -0500
Received: from mx1.suse.de ([195.135.220.2]:58836 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161622AbWJaENL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:13:11 -0500
From: Neil Brown <neilb@suse.de>
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Date: Tue, 31 Oct 2006 15:13:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17734.52558.476874.72042@cse.unsw.edu.au>
Cc: "Trond Myklebust" <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org, "Andy Adamson" <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       "Olaf Kirch" <okir@monad.swb.de>
Subject: Re: [PATCH 2/2] auth_gss: unregister gss_domain when unloading module
In-Reply-To: message from Akinobu Mita on Tuesday October 31
References: <20061028185554.GM9973@localhost>
	<20061029133551.GA10072@localhost>
	<20061029133700.GA10295@localhost>
	<20061029133816.GB10295@localhost>
	<1162152960.5545.57.camel@lade.trondhjem.org>
	<20061030145404.GA7258@localhost>
	<1162221449.5517.70.camel@lade.trondhjem.org>
	<961aa3350610301915i5a954dbemd5420a350fd0c625@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 31, akinobu.mita@gmail.com wrote:
> 
> But I noticed that even if we have this kind of smp-safe code, there
> is no guarantee that 2nd auth_domain_put() in
> svcauth_gss_unregister_pseudoflavor() is the last reference of
> this gss_domain.
> 
> So it is possible to happen invalid dereference by real last user of
> this gss_domain after unloading module. If this is not wrong,
> Is it neccesary to have try_get_module()/put_module() somewhere to
> prevent this?

After a quick look, it seems to me that one reasonable option would
be:

  svcauth_gss_register_pseudoflavor
     returns a void* which is 'new', and possible calls try_get_module(),
     failing if that fails. and
  svcauth_gss_unregister_pseudoflavor
     takes the void* (not a name) and calls auth_domain_put on it, and
     then calls put_module().

  'struct pf_desc' would have to gain a
        void * handle;
  to hold the returned value.

Would that solve the problem as you see it?

NeilBrown
