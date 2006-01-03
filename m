Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWACGrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWACGrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 01:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWACGrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 01:47:48 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:48036 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751182AbWACGrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 01:47:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usb: replace __setup("nousb") with __module_param_call
Date: Tue, 3 Jan 2006 01:47:46 -0500
User-Agent: KMail/1.8.3
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20051220141504.31441a41.zaitcev@redhat.com> <200512220110.52466.dtor_core@ameritech.net> <20051222002423.1791d38b.zaitcev@redhat.com>
In-Reply-To: <20051222002423.1791d38b.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601030147.46504.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 December 2005 03:24, Pete Zaitcev wrote:
> On Thu, 22 Dec 2005 01:10:52 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Tuesday 20 December 2005 17:15, Pete Zaitcev wrote:
> 
> > > Fedora users complain that passing "nousbstorage" to the installer causes
> > > the rest of the USB support to disappear. The installer uses kernel command
> > > line as a way to pass options through Syslinux. The problem stems from the
> > > use of strncmp() in obsolete_checksetup().
> 
> > I wonder if that strncmp() should be changed into something like
> > this (untested):
> > 
> > --- work.orig/init/main.c
> > +++ work/init/main.c
> > @@ -167,7 +167,7 @@ static int __init obsolete_checksetup(ch
> >  	p = __setup_start;
> >  	do {
> >  		int n = strlen(p->str);
> > -		if (!strncmp(line, p->str, n)) {
> > +		if (!strncmp(line, p->str, n) && !isalnum(line[n])) {
> >  			if (p->early) {
> 
> Are you sure that your fix works well in case of __setup("foo=")?
> It probably breaks all of those.
> 

Yes, of course you are right. What do you think about the patch below?
I think it shoudl handle the case of one option being a prefix for
another.

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 init/main.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

Index: work/init/main.c
===================================================================
--- work.orig/init/main.c
+++ work/init/main.c
@@ -160,24 +160,22 @@ static const char *panic_later, *panic_p
 
 extern struct obs_kernel_param __setup_start[], __setup_end[];
 
-static int __init obsolete_checksetup(char *line)
+static int __init obsolete_checksetup(char *line, int len)
 {
 	struct obs_kernel_param *p;
 
 	p = __setup_start;
 	do {
-		int n = strlen(p->str);
-		if (!strncmp(line, p->str, n)) {
+		if (!strncmp(line, p->str, len) && len == strlen(p->str)) {
 			if (p->early) {
-				/* Already done in parse_early_param?  (Needs
-				 * exact match on param part) */
-				if (line[n] == '\0' || line[n] == '=')
-					return 1;
+				/* Already done in parse_early_param? */
+				return 1;
 			} else if (!p->setup_func) {
-				printk(KERN_WARNING "Parameter %s is obsolete,"
-				       " ignored\n", p->str);
+				printk(KERN_WARNING
+					"Parameter %s is obsolete, ignored\n",
+					p->str);
 				return 1;
-			} else if (p->setup_func(line + n))
+			} else if (p->setup_func(line + len))
 				return 1;
 		}
 		p++;
@@ -226,21 +224,25 @@ __setup("loglevel=", loglevel);
  */
 static int __init unknown_bootoption(char *param, char *val)
 {
+	int len = strlen(param);
+
 	/* Change NUL term back to "=", to make "param" the whole string. */
 	if (val) {
 		/* param=val or param="val"? */
-		if (val == param+strlen(param)+1)
+		if (val == param + len + 1) {
 			val[-1] = '=';
-		else if (val == param+strlen(param)+2) {
+			len++;
+		} else if (val == param + len + 2) {
 			val[-2] = '=';
-			memmove(val-1, val, strlen(val)+1);
+			memmove(val - 1, val, strlen(val) + 1);
 			val--;
+			len++;
 		} else
 			BUG();
 	}
 
 	/* Handle obsolete-style parameters */
-	if (obsolete_checksetup(param))
+	if (obsolete_checksetup(param, len))
 		return 0;
 
 	/*
