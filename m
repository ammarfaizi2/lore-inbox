Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSJJQU4>; Thu, 10 Oct 2002 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJJQU4>; Thu, 10 Oct 2002 12:20:56 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:22418 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261663AbSJJQTx>;
	Thu, 10 Oct 2002 12:19:53 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Grothe <dave@gcom.com>
Date: Thu, 10 Oct 2002 18:25:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com, bidulock@openss7.org
X-mailer: Pegasus Mail v3.50
Message-ID: <438353D513A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Oct 02 at 11:01, David Grothe wrote:
> 
> Does this patch address your suggestions?  This has been tested on 2.4.19.

Well, it can be that way. But if you are allowing
register_streams_calls(NULL, NULL), maybe you can move 
unregister_streams_calls() to the headers and make it inline.

And you are returning while holding streams_call_sem semaphore
when failing with -EBUSY. It is not good idea.
                                Petr Vandrovec
                                vandrove@vc.cvut.cz                                                    

+int register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
+               int (*getpmsg) (int, void *, void *, int, int))
+{
+   down_write(&streams_call_sem) ; /* should return int, but doesn't */
+   if (   (putpmsg != NULL && do_putpmsg != NULL)
+       || (getpmsg != NULL && do_getpmsg != NULL)
+      )
+       return -EBUSY;
+   do_putpmsg = putpmsg;
+   do_getpmsg = getpmsg;
+   up_write(&streams_call_sem);
+   return 0 ;
+}
+
+void unregister_streams_calls(void)
+{
+   register_streams_calls(NULL, NULL);
+}
+
 asmlinkage long sys_ni_syscall(void)
 {
    return -ENOSYS;
