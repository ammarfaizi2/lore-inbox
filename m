Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136368AbREDMrP>; Fri, 4 May 2001 08:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136370AbREDMrG>; Fri, 4 May 2001 08:47:06 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:1540 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136368AbREDMqv>;
	Fri, 4 May 2001 08:46:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Todd Inglett <tinglett@vnet.ibm.com>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct 
In-Reply-To: Your message of "Fri, 04 May 2001 07:34:20 EST."
             <3AF2A1CC.C22A48E7@vnet.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 May 2001 22:46:43 +1000
Message-ID: <8541.988980403@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 May 2001 07:34:20 -0500, 
Todd Inglett <tinglett@vnet.ibm.com> wrote:
>But this is where hell breaks loose.  Every process has a valid parent
>-- unless it is dead and nobody cares.  Process N has already exited and
>released from the tasklist while its parent was still alive.  There was
>no reason to reparent it.  It just got released.  So N's task_struct has
>a dangling ptr to its parent.  Nobody is holding the parent task_struct,
>either.  When the parent died memory for its task_struct was released. 
>This is ungood.

Wrap the reference to the parent task structure with exception table
recovery code, like copy_from_user().  If the dangling reference points
to valid memory the worst that will happen is that you read and report
gibberish for one output.  If the reference causes an exception then
recover and treat it as NULL.  For a read only case, the only important
thing is not to die, one occurrence of bad data is tolerable.

