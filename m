Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263520AbTDCThS 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263524AbTDCThS 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:37:18 -0500
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:6644 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263520AbTDCThK 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:37:10 -0500
Importance: Normal
Sensitivity: 
Subject: Re: gcc-3.2 breaks rmap on s390x
To: hugh@veritas.com, zaitcev@redhat.com, riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFEA6A4CF2.EF4982E0-ONC1256CFD.006A9D4F@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 3 Apr 2003 21:42:25 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/04/2003 21:42:28
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>Isn't it rather odd that it should fix the problem you describe?
>because the barrier you're adding comes only in the exceptional path,
>when the lock was found already held.  I suppose the compiler is free
>to make the barrier more general than you've asked for, but it seems
>unsafe to rely on that.

No, it's the other way around:  the compiler is free to ignore the
barrier only if can prove the path containing it is not taken
(which it cannot in this case as the outer while depends on a volatile
test_and_set_bit operation).


However, this code still contains a (theoretical) problem:

>       while (test_and_set_bit(PG_chainlock, &page->flags)) {
> -             while (test_bit(PG_chainlock, &page->flags))
> +             while (test_bit(PG_chainlock, &page->flags)) {
>                       cpu_relax();
> +                     barrier();
> +             }

nothing in the inner loop contains a (hardware) memory barrier
('serialization' in s390-speak), so nothing forces the processor
to ever refresh its cached value of page->flags from memory.

On s390, the architecture definition would allow a processor
to loop endlessly (that is, until the next interrupt, which
serves as serialization operation).  However, none of the currently
existing processors do that, so the problem is only theoretical ...


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

