Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312559AbSDEM7m>; Fri, 5 Apr 2002 07:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312562AbSDEM7X>; Fri, 5 Apr 2002 07:59:23 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:59029 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312559AbSDEM7J>; Fri, 5 Apr 2002 07:59:09 -0500
Date: Fri, 5 Apr 2002 14:59:00 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: socket write(2) after remote shutdown(2) problem ?
Message-ID: <20020405125900.GI16595@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020405105509.GE16595@come.alcove-fr> <20020405.030251.28451401.davem@redhat.com> <20020405120054.GF16595@come.alcove-fr> <20020405.040451.127871174.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 04:04:51AM -0800, David S. Miller wrote:

>    As you can see, read() doesn't return any error, just 0 to 
>    indicate end-of-file (seems correct interpretation of remote
>    shutdown here), but it doesn't report any error from the 
>    precedent write... Bug ?
> 
> Race, wait a bit, the reset will arrive.

Ok, I investigated this a bit more using setsockopt(...,SO_ERROR,...)

After the write in the client (which is done after the server has
shutdown()'ed it), the error bit is set on the client socket
(-EPIPE).

If the client issues a second write, the write fails (correctly)
setting errno to -EPIPE.

If the client issues a read, read doesn't return an error. The 
socket error bit is still there however, even after read() returns.

If the client issues a close, close will return 0 too.

Whether the read() should return the error bit or not is
debatable, but IMHO close at least should propagate the error.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
