Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751753AbWJERwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWJERwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWJERwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:52:12 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:41501 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751753AbWJERwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:52:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMmgGQXZBGz8Ch70CRfAeAcLnzIwvQygJq3XwTe5/DxZt7mJ9ZV+yffDL4WT6jFMw5VU+Cuq5+mHv5yKXRh2Po93PjZXZf2aEFi6Fp1H0UoB8LCaAapABj//vtqkC8nHd+JK4nJWKVNCuGGHZFcaNb727le6rBeYtIg6xDNR5lE=
Message-ID: <e5bfff550610051052q48d26e1cib8b550146649772f@mail.gmail.com>
Date: Thu, 5 Oct 2006 19:52:10 +0200
From: "Marco Costalba" <mcostalba@gmail.com>
To: linux-kernel@vger.kernel.org, sam@ravnborg.org, zippel@linux-m68k.org
Subject: [PATCH 1/1] kconfig: ask for saving configuration before quitting when something changed
In-Reply-To: <e5bfff550610051014y41e9aecfna347e281f17dc5a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e5bfff550610051014y41e9aecfna347e281f17dc5a5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

While there I've found this nice TODO.


 scripts/kconfig/qconf.cc |   59 ++++++++++++++++++++++++++++++++++++++++++++--
 scripts/kconfig/qconf.h  |   13 ++++++++++
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index eec81b0..6f4c360 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -37,6 +37,26 @@ #endif

 static QApplication *configApp;
 static ConfigSettings *configSettings;
+static QMap<struct symbol*, SymValue> touchedSyms;
+
+static void aboutToChange(struct symbol* sym)
+{
+       if (sym && !touchedSyms.contains(sym)) {
+               SymValue originalValue(sym);
+               touchedSyms.insert(sym, originalValue);
+       }
+}
+
+static bool isSomethingChanged()
+{
+       QMap<struct symbol*, SymValue>::Iterator it;
+       for (it = touchedSyms.begin(); it != touchedSyms.end(); ++it) {
+               SymValue curVal(it.key());
+               if (curVal != it.data())
+                       return true;
+       }
+       return false;
+}

 static inline QString qgettext(const char* str)
 {
@@ -48,6 +68,33 @@ static inline QString qgettext(const QSt
        return QString::fromLocal8Bit(gettext(str.latin1()));
 }

+bool SymValue::operator!=(const SymValue& v)
+{
+       if (v.type != type)
+               return true;
+
+       if (type == S_BOOLEAN || type == S_TRISTATE)
+               return v.expr != expr;
+
+       return v.data != data;
+}
+
+void SymValue::readValue(struct symbol* sym)
+{
+       type = sym_get_type(sym);
+       switch (type) {
+       case S_BOOLEAN:
+       case S_TRISTATE:
+               expr = sym_get_tristate_value(sym);
+               break;
+       case S_INT:
+       case S_HEX:
+       case S_STRING:
+               data = sym_get_string_value(sym);
+               break;
+       }
+}
+
 /**
  * Reads a list of integer values from the application settings.
  */
@@ -86,6 +133,7 @@ #if QT_VERSION >= 300
 void ConfigItem::okRename(int col)
 {
        Parent::okRename(col);
+       aboutToChange(menu->sym);
        sym_set_string_value(menu->sym, text(dataColIdx).latin1());
 }
 #endif
@@ -298,6 +346,7 @@ void ConfigLineEdit::keyPressEvent(QKeyE
                break;
        case Key_Return:
        case Key_Enter:
+               aboutToChange(item->menu->sym);
                sym_set_string_value(item->menu->sym, text().latin1());
                parent()->updateList(item);
                break;
@@ -469,7 +518,7 @@ void ConfigList::setValue(ConfigItem* it
        case S_BOOLEAN:
        case S_TRISTATE:
                oldval = sym_get_tristate_value(sym);
-
+               aboutToChange(sym);
                if (!sym_set_tristate_value(sym, val))
                        return;
                if (oldval == no && item->menu->list)
@@ -500,6 +549,7 @@ void ConfigList::changeValue(ConfigItem*
        case S_BOOLEAN:
        case S_TRISTATE:
                oldexpr = sym_get_tristate_value(sym);
+               aboutToChange(sym);
                newexpr = sym_toggle_tristate_value(sym);
                if (item->menu->list) {
                        if (oldexpr == newexpr)
@@ -1442,6 +1492,8 @@ void ConfigMainWindow::saveConfig(void)
 {
        if (conf_write(NULL))
                QMessageBox::information(this, "qconf", "Unable to
save configuration!");
+       else
+               touchedSyms.clear();
 }

 void ConfigMainWindow::saveConfigAs(void)
@@ -1451,6 +1503,8 @@ void ConfigMainWindow::saveConfigAs(void
                return;
        if (conf_write(QFile::encodeName(s)))
                QMessageBox::information(this, "qconf", "Unable to
save configuration!");
+       else
+               touchedSyms.clear();
 }

 void ConfigMainWindow::searchConfig(void)
@@ -1583,11 +1637,10 @@ void ConfigMainWindow::showFullView(void

 /*
  * ask for saving configuration before quitting
- * TODO ask only when something changed
  */
 void ConfigMainWindow::closeEvent(QCloseEvent* e)
 {
-       if (!sym_change_count) {
+       if (!isSomethingChanged()) {
                e->accept();
                return;
        }
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 8d11f3c..8617698 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -45,6 +45,19 @@ enum listMode {
        singleMode, menuMode, symbolMode, fullMode, listMode
 };

+class SymValue {
+public:
+       SymValue() {}; // QMap needs this to store us
+       SymValue(struct symbol* sym) { readValue(sym); }
+       bool operator!=(const SymValue&);
+private:
+       void readValue(struct symbol* sym);
+
+       int type;
+       tristate expr;
+       QString data;
+};
+
 class ConfigList : public QListView {
        Q_OBJECT
        typedef class QListView Parent;
--
1.4.2.1.gbc1a5
