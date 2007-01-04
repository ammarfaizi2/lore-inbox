Return-Path: <linux-kernel-owner+w=401wt.eu-S932224AbXADSH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXADSH4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbXADSHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:07:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:18573 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbXADSHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:07:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:disposition-notification-to:mime-version:content-disposition:message-id:cc:content-type:content-transfer-encoding;
        b=SIz5zeME9Mq/BwG16pYPJ/NDOIJLe9j1f8WQlpqVYIsH8x4N7aEaYbe6iauADbaZ8XwfYWu0M2/E9HFnTM0X/YaJREtyWuaBL5aL2zg0C4V86NKUN4nSq2TG+SzQeC3oDZZl4rg4SQ4OptfYfFJIVNRJDE25Yhaqmk4ZV7s8w+o=
From: "Cyrill V. Gorcunov" <gorcunov@gmail.com>
Reply-To: gorcunov@gmail.com
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] qconf: fix SIGSEGV on empty menu items
Date: Thu, 4 Jan 2007 21:06:37 +0300
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701042106.37338.gorcunov@gmail.com>
Cc: zippel@linux-m68k.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

qconf may cause SIGSEGV by trying to show debug
information on empty menu items

Signed-off-by: Cyrill V. Gorcunov <gorcunov@gmail.com>
---
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 0b2fcc4..0694d1d 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -925,6 +925,8 @@ ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
                configSettings->endGroup();
                connect(configApp, SIGNAL(aboutToQuit()), SLOT(saveSettings()));
        }
+
+       has_dbg_info = 0;
 }
 
 void ConfigInfoView::saveSettings(void)
@@ -953,10 +955,13 @@ void ConfigInfoView::setInfo(struct menu *m)
        if (menu == m)
                return;
        menu = m;
-       if (!menu)
+       if (!menu) {
+               has_dbg_info = 0;
                clear();
-       else
+       } else {
+               has_dbg_info = 1;
                menuInfo();
+       }
 }
 
 void ConfigInfoView::setSource(const QString& name)
@@ -991,6 +996,9 @@ void ConfigInfoView::symbolInfo(void)
 {
        QString str;
 
+       if (!has_dbg_info)
+               return;
+
        str += "<big>Symbol: <b>";
        str += print_filter(sym->name);
        str += "</b></big><br><br>value: ";
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 6fc1c5f..a397edb 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -273,6 +273,8 @@ protected:
        struct symbol *sym;
        struct menu *menu;
        bool _showDebug;
+
+       int has_dbg_info;
 };
 
 class ConfigSearchWindow : public QDialog {
