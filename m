Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbSJJQYw>; Thu, 10 Oct 2002 12:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbSJJQYw>; Thu, 10 Oct 2002 12:24:52 -0400
Received: from email.gcom.com ([206.221.230.194]:2491 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S261694AbSJJQYv>;
	Thu, 10 Oct 2002 12:24:51 -0400
Message-Id: <5.1.0.14.2.20021010112905.027a3090@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 10 Oct 2002 11:30:28 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
From: David Grothe <dave@gcom.com>
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com, bidulock@openss7.org
In-Reply-To: <438353D513A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks better:

int register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
                             int (*getpmsg) (int, void *, void *, int, int))
{
         int ret = 0;
         down_write(&streams_call_sem) ; /* should return int, but doesn't */
         if (   (putpmsg != NULL && do_putpmsg != NULL)
             || (getpmsg != NULL && do_getpmsg != NULL)
            )
                 ret = -EBUSY;
         else {
                 do_putpmsg = putpmsg;
                 do_getpmsg = getpmsg;
         }
         up_write(&streams_call_sem);
         return 0 ;
}

How about if we just eliminate the unregister_streams routine?  LiS can 
just call register_streams(NULL,NULL) when it wants to unregister.

-- Dave

At 06:25 PM 10/10/2002 Thursday, Petr Vandrovec wrote:
>On 10 Oct 02 at 11:01, David Grothe wrote:
> >
> > Does this patch address your suggestions?  This has been tested on 2.4.19.
>
>Well, it can be that way. But if you are allowing
>register_streams_calls(NULL, NULL), maybe you can move
>unregister_streams_calls() to the headers and make it inline.
>
>And you are returning while holding streams_call_sem semaphore
>when failing with -EBUSY. It is not good idea.
>                                 Petr Vandrovec
>                                 vandrove@vc.cvut.cz 
>
>
>+int register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
>+               int (*getpmsg) (int, void *, void *, int, int))
>+{
>+   down_write(&streams_call_sem) ; /* should return int, but doesn't */
>+   if (   (putpmsg != NULL && do_putpmsg != NULL)
>+       || (getpmsg != NULL && do_getpmsg != NULL)
>+      )
>+       return -EBUSY;
>+   do_putpmsg = putpmsg;
>+   do_getpmsg = getpmsg;
>+   up_write(&streams_call_sem);
>+   return 0 ;
>+}
>+
>+void unregister_streams_calls(void)
>+{
>+   register_streams_calls(NULL, NULL);
>+}
>+
>  asmlinkage long sys_ni_syscall(void)
>  {
>     return -ENOSYS;

