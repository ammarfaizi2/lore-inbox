Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWAKN7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWAKN7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWAKN7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:59:51 -0500
Received: from ns.firmix.at ([62.141.48.66]:50914 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751633AbWAKN7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:59:50 -0500
Subject: Re: OT: fork(): parent or child should run first?
From: Bernd Petrovitsch <bernd@firmix.at>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       lgb@lgb.hu
In-Reply-To: <1136987361.6517.1.camel@localhost.localdomain>
References: <20060111123745.GB30219@lgb.hu>
	 <1136983910.2929.39.camel@laptopd505.fenrus.org>
	 <20060111130255.GC30219@lgb.hu>  <1136985918.6547.115.camel@tara.firmix.at>
	 <1136987361.6517.1.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 11 Jan 2006 14:55:43 +0100
Message-Id: <1136987743.6547.122.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 13:49 +0000, Ian Campbell wrote:
> On Wed, 2006-01-11 at 14:25 +0100, Bernd Petrovitsch wrote:
> > Then this leaves the race if an old pid is reused in a newly created
> > process before the last instances of that pid is cleaned up.
> 
> The PID won't be available to be re-used until the signal handler has
> called waitpid() on it?

Yes.
But ATM the signal handler calls waitpid() and stores the pid in a
to-be-cleaned-pids array (at time X).
The main loop at some time in the future (say at time X+N) walks through
the to-be-cleaned-pids array and cleans them from the active-childs
array.
If a new process is started between X and X+N with a pid in the
to-be-cleaned-pids it may happen (depends on the implementation - if the
active-childs array is "sorted" as childs are created (i.e. just append
the new pid at the end), holes of terminated childs are closed with
moving the rest of array and *never* reordered, than it may even work
then) that the wrong one (or both) are cleaned up.
But IMHO a too fragile solution in the log run as this doesn't scale and
people are inclined to tune it with sorting, hashing, etc.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

