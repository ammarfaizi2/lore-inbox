Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283784AbRK3U5O>; Fri, 30 Nov 2001 15:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283779AbRK3U4h>; Fri, 30 Nov 2001 15:56:37 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:24259 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S283737AbRK3U41>;
	Fri, 30 Nov 2001 15:56:27 -0500
Date: Fri, 30 Nov 2001 12:56:22 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir245_af_ias.diff
Message-ID: <20011130125622.D3938@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir245_af_ias.diff :
-----------------
	o [CORRECT] Restrict write access to IAS database to ROOT. Users can
	  only write IAS object attached to their own socket. This avoid apps
	  polluting each other.
	o [FEATURE] Empty IAS classname will refer to object attached to
	  present socket.

diff -u -p linux/net/irda/af_irda.d3.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d3.c	Wed Nov 28 10:21:31 2001
+++ linux/net/irda/af_irda.c	Wed Nov 28 14:13:43 2001
@@ -1845,15 +1845,36 @@ static int irda_setsockopt(struct socket
 		  	return -EFAULT;
 		}
 
-		/* Find the object we target */
-		ias_obj = irias_find_object(ias_opt->irda_class_name);
+		/* Find the object we target.
+		 * If the user gives us an empty string, we use the object
+		 * associated with this socket. This will workaround
+		 * duplicated class name - Jean II */
+		if(ias_opt->irda_class_name[0] == '\0') {
+			if(self->ias_obj == NULL) {
+				kfree(ias_opt);
+				return -EINVAL;
+			}
+			ias_obj = self->ias_obj;
+		} else
+			ias_obj = irias_find_object(ias_opt->irda_class_name);
+
+		/* Only ROOT can mess with the global IAS database.
+		 * Users can only add attributes to the object associated
+		 * with the socket they own - Jean II */
+		if((!capable(CAP_NET_ADMIN)) &&
+		   ((ias_obj == NULL) || (ias_obj != self->ias_obj))) {
+			kfree(ias_opt);
+			return -EPERM;
+		}
+
+		/* If the object doesn't exist, create it */
 		if(ias_obj == (struct ias_object *) NULL) {
 			/* Create a new object */
 			ias_obj = irias_new_object(ias_opt->irda_class_name,
 						   jiffies);
 		}
 
-		/* Do we have it already ? */
+		/* Do we have the attribute already ? */
 		if(irias_find_attrib(ias_obj, ias_opt->irda_attrib_name)) {
 			kfree(ias_opt);
 			return -EINVAL;
@@ -1927,13 +1948,28 @@ static int irda_setsockopt(struct socket
 		  	return -EFAULT;
 		}
 
-		/* Find the object we target */
-		ias_obj = irias_find_object(ias_opt->irda_class_name);
+		/* Find the object we target.
+		 * If the user gives us an empty string, we use the object
+		 * associated with this socket. This will workaround
+		 * duplicated class name - Jean II */
+		if(ias_opt->irda_class_name[0] == '\0')
+			ias_obj = self->ias_obj;
+		else
+			ias_obj = irias_find_object(ias_opt->irda_class_name);
 		if(ias_obj == (struct ias_object *) NULL) {
 			kfree(ias_opt);
 			return -EINVAL;
 		}
 
+		/* Only ROOT can mess with the global IAS database.
+		 * Users can only del attributes from the object associated
+		 * with the socket they own - Jean II */
+		if((!capable(CAP_NET_ADMIN)) &&
+		   ((ias_obj == NULL) || (ias_obj != self->ias_obj))) {
+			kfree(ias_opt);
+			return -EPERM;
+		}
+
 		/* Find the attribute (in the object) we target */
 		ias_attr = irias_find_attrib(ias_obj,
 					     ias_opt->irda_attrib_name); 
@@ -2166,8 +2202,14 @@ bed:
 		  	return -EFAULT;
 		}
 
-		/* Find the object we target */
-		ias_obj = irias_find_object(ias_opt->irda_class_name);
+		/* Find the object we target.
+		 * If the user gives us an empty string, we use the object
+		 * associated with this socket. This will workaround
+		 * duplicated class name - Jean II */
+		if(ias_opt->irda_class_name[0] == '\0')
+			ias_obj = self->ias_obj;
+		else
+			ias_obj = irias_find_object(ias_opt->irda_class_name);
 		if(ias_obj == (struct ias_object *) NULL) {
 			kfree(ias_opt);
 			return -EINVAL;
