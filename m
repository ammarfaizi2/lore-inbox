Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVC3OPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVC3OPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVC3OPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:15:15 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:32681 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261912AbVC3OPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:15:02 -0500
Date: Wed, 30 Mar 2005 18:14:12 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Jay Lan <jlan@engr.sgi.com>, guillaume.thouvenin@bull.net, akpm@osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-ID: <20050330181412.B13722@2ka.mipt.ru>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr> <20050328134242.4c6f7583.pj@engr.sgi.com> <1112079856.5243.24.camel@uganda> <20050329004915.27cd0edf.pj@engr.sgi.com> <1112092197.5243.80.camel@uganda> <20050329090304.23fbb340.pj@engr.sgi.com> <4249C418.5040007@engr.sgi.com> <20050329140106.2a9b8aa5.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050329140106.2a9b8aa5.pj@engr.sgi.com>; from pj@engr.sgi.com on Tue, Mar 29, 2005 at 02:01:06PM -0800
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 30 Mar 2005 18:14:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for long delay - I was quite far from my test machines.
Here are results:

fork connector with turned off disk writes and direct connector's 
methods calls.

pcix$ ./fork_test 100000
Average per process fork+exit time is 505 usecs [diff=50567251, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 512 usecs [diff=51248174, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 504 usecs [diff=50469379, max=100000].

fork connector with turned on disk writes and direct connector's 
methods calls. 
Each disk write has about 80 bytes which are:
	time(&tm);
	fprintf(out,
		"%.24s : [%x.%x] [seq=%08x, ack=%08x] %s.\n",
		ctime(&tm), data->id.idx, data->id.val,
		data->seq, data->ack, (char *)data->data);

pcix$ ./fork_test 100000
Average per process fork+exit time is 539 usecs [diff=53944663, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 523 usecs [diff=52378314, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 540 usecs [diff=54078648, max=100000].

CBUS results.

Writing disabled:

pcix$ ./fork_test 100000
Average per process fork+exit time is 451 usecs [diff=45194377, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 454 usecs [diff=45416470, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 448 usecs [diff=44863153, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 453 usecs [diff=45312870, max=100000].
pcix$

Writing enabled like described above:

pcix$ ./fork_test 100000
Average per process fork+exit time is 456 usecs [diff=45680384, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 455 usecs [diff=45590682, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 453 usecs [diff=45376436, max=100000].
pcix$


fork connector is not compiled in:

Average per process fork+exit time is 452 usecs [diff=45280538, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 446 usecs [diff=44687388, max=100000].
pcix$ ./fork_test 100000
Average per process fork+exit time is 445 usecs [diff=44505999, max=100000].
pcix$ ./fork_test 100000


With 80 bytes write per fork with CBUS it takes from 0.5% to 2.5%.
So it still can be used for accounting :)

-- 
	Evgeniy Polyakov
