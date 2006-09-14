Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWINWK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWINWK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWINWK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:10:26 -0400
Received: from MAIL.13thfloor.at ([213.145.232.33]:53418 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S1751361AbWINWKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:10:25 -0400
Date: Fri, 15 Sep 2006 00:10:24 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, containers@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH/RFC] kthread API conversion for dvb_frontend and av7110
Message-ID: <20060914221024.GB26916@MAIL.13thfloor.at>
Mail-Followup-To: Cedric Le Goater <clg@fr.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	containers@lists.osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>,
	Andrew de Quincey <adq_dvb@lidskialf.net>
References: <45019CC3.2030709@fr.ibm.com> <m18xktkbli.fsf@ebiederm.dsl.xmission.com> <450537B6.1020509@fr.ibm.com> <m1u03eacdc.fsf@ebiederm.dsl.xmission.com> <45056D3E.6040702@fr.ibm.com> <m14pve9qip.fsf@ebiederm.dsl.xmission.com> <20060912110559.GD23808@MAIL.13thfloor.at> <20060914200103.GA8448@MAIL.13thfloor.at> <4509C4A5.5030600@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509C4A5.5030600@fr.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 11:07:49PM +0200, Cedric Le Goater wrote:
> Herbert Poetzl wrote:
> > Okay, as I promised, I had a first shot at the
> > dvb kernel_thread to kthread API port, and here
> > is the result, which is running fine here since
> > yesterday, including module load/unload and
> > software suspend (which doesn't work as expected
> > with or without this patch :),
> 
> So you have such an hardware ? 

yes, I do .. that's how I tested it :)

> [ ...  ]
> 
> > @@ -600,7 +595,6 @@ static int dvb_frontend_thread(void *dat
> >  
> >  static void dvb_frontend_stop(struct dvb_frontend *fe)
> >  {
> > -	unsigned long ret;
> >  	struct dvb_frontend_private *fepriv = fe->frontend_priv;
> >  
> >  	dprintk ("%s\n", __FUNCTION__);
> > @@ -608,33 +602,17 @@ static void dvb_frontend_stop(struct dvb
> >  	fepriv->exit = 1;
> 
> do we still need the ->exit flag now that we are using kthread_stop() ? 
> same question for ->wakeup ? 

probably not, but I didn't want to change too
much on the first try, especially I'd appreciate
some feedback to this from the maintainer(s)

> >  	mb();
> >  
> > -	if (!fepriv->thread_pid)
> > -		return;
> > -
> > -	/* check if the thread is really alive */
> > -	if (kill_proc(fepriv->thread_pid, 0, 1) == -ESRCH) {
> > -		printk("dvb_frontend_stop: thread PID %d already died\n",
> > -				fepriv->thread_pid);
> > -		/* make sure the mutex was not held by the thread */
> > -		init_MUTEX (&fepriv->sem);
> > +	if (!fepriv->thread)
> >  		return;
> > -	}
> > -
> > -	/* wake up the frontend thread, so it notices that fe->exit == 1 */
> > -	dvb_frontend_wakeup(fe);
> >  
> > -	/* wait until the frontend thread has exited */
> > -	ret = wait_event_interruptible(fepriv->wait_queue,0 == fepriv->thread_pid);
> > -	if (-ERESTARTSYS != ret) {
> > -		fepriv->state = FESTATE_IDLE;
> > -		return;
> > -	}
> > +	kthread_stop(fepriv->thread);
> > +	init_MUTEX (&fepriv->sem);
> 
> the use of the semaphore to synchronise the thread is complex. It will
> require extra care to avoid deadlocks.

well, it 'works' quite fine for now, but yeah, I
thought about completely removing the additional
synchronization and 'jsut' go with the kthread
one, if that is sufficient ...

> >  	fepriv->state = FESTATE_IDLE;
> >  
> >  	/* paranoia check in case a signal arrived */
> > -	if (fepriv->thread_pid)
> > -		printk("dvb_frontend_stop: warning: thread PID %d won't exit\n",
> > -				fepriv->thread_pid);
> > +	if (fepriv->thread)
> > +		printk("dvb_frontend_stop: warning: thread %p won't exit\n",
> > +				fepriv->thread);
> 
> kthread_stop uses a completion already. so the above is real paranoia :)

again, I think this will go away soon :)

> >  }
> >  
> >  s32 timeval_usec_diff(struct timeval lasttime, struct timeval curtime)
> > @@ -684,10 +662,11 @@ static int dvb_frontend_start(struct dvb
> >  {
> >  	int ret;
> >  	struct dvb_frontend_private *fepriv = fe->frontend_priv;
> > +	struct task_struct *fe_thread;
> >  
> >  	dprintk ("%s\n", __FUNCTION__);
> >  
> > -	if (fepriv->thread_pid) {
> > +	if (fepriv->thread) {
> >  		if (!fepriv->exit)
> >  			return 0;
> >  		else
> > @@ -701,18 +680,18 @@ static int dvb_frontend_start(struct dvb
> >  
> >  	fepriv->state = FESTATE_IDLE;
> >  	fepriv->exit = 0;
> > -	fepriv->thread_pid = 0;
> > +	fepriv->thread = NULL;
> >  	mb();
> >  
> > -	ret = kernel_thread (dvb_frontend_thread, fe, 0);
> > -
> > -	if (ret < 0) {
> > -		printk("dvb_frontend_start: failed to start kernel_thread (%d)\n", ret);
> > +	fe_thread = kthread_run(dvb_frontend_thread, fe,
> > +		"kdvb-fe-%i", fe->dvb->num);
> > +	if (IS_ERR(fe_thread)) {
> > +		ret = PTR_ERR(fe_thread);
> 
> ret could be local.

correct, will fix that up in the next round

thanks for the feedback,
Herbert

> [ ... ] 
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers
