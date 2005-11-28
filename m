Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVK1VQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVK1VQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVK1VQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:16:13 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:15280 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932103AbVK1VQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:16:11 -0500
Date: Mon, 28 Nov 2005 19:16:05 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm <akpm@osdl.org>, ehabkost@mandriva.com
Subject: [RESEND 1/2] - usbserial: Adds missing checks and bug fix.
Message-Id: <20051128191605.096bb777.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Checks if 'port' is NULL before using it in all tty operations, this
can avoid NULL pointer dereferences.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/usb-serial.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -188,6 +188,8 @@ static int serial_open (struct tty_struc
 
 	portNumber = tty->index - serial->minor;
 	port = serial->port[portNumber];
+	if (!port)
+		return -ENODEV;
 	 
 	++port->open_count;
 
@@ -258,6 +260,9 @@ static int serial_write (struct tty_stru
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -EINVAL;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d, %d byte(s)", __FUNCTION__, port->number, count);
 
 	if (!port->open_count) {
@@ -277,6 +282,9 @@ static int serial_write_room (struct tty
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -EINVAL;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -296,6 +304,9 @@ static int serial_chars_in_buffer (struc
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -EINVAL;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s = port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -314,6 +325,9 @@ static void serial_throttle (struct tty_
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -330,6 +344,9 @@ static void serial_unthrottle (struct tt
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -347,6 +364,9 @@ static int serial_ioctl (struct tty_stru
 	struct usb_serial_port *port = tty->driver_data;
 	int retval = -ENODEV;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d, cmd 0x%.4x", __FUNCTION__, port->number, cmd);
 
 	if (!port->open_count) {
@@ -368,6 +388,9 @@ static void serial_set_termios (struct t
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -384,6 +407,9 @@ static void serial_break (struct tty_str
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		return;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -445,6 +471,9 @@ static int serial_tiocmget (struct tty_s
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {
@@ -464,6 +493,9 @@ static int serial_tiocmset (struct tty_s
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (!port)
+		goto exit;
+
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (!port->open_count) {


-- 
Luiz Fernando N. Capitulino
