Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVC0QGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVC0QGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 11:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVC0QGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 11:06:06 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:35459 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261787AbVC0QFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 11:05:54 -0500
Date: Sun, 27 Mar 2005 21:36:18 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: keyboard driver function hijacking
Message-ID: <Pine.LNX.4.60.0503272114190.12247@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai all,
    I applied the hijacking mechanism(by Silvio) on the handle_scancode fn 
of keyboard driver.It worked fine. I want to open a /proc file(which was created by 
another program) , to read its contents on pressing certain key.
But if I press that perticular key ,system is hanging and printing In 
Interrupt Handler not --syncing.
   Is there any other way to perform the above task.
   Below is the code written:


static char original_handle_scancode[CODESIZE];
static char acct_code[CODESIZE] =
        "\xb8\x00\x00\x00\x00"      /*      movl   $0,%eax  */
        "\xff\xe0"                  /*      jmp    *%eax    */
    ;

void (*handle_scancode) (unsigned char, int) =
        (void (*)(unsigned char, int)) 0xc01b0cd0;

void _handle_scancode(unsigned char scancode, int keydown)
{
        static int myflag = 0;
        int value,i;


         int length_read1;

         char buffer1[250];
         struct file * f1 = NULL;
         mm_segment_t orig_fs1;

         file_to_read1 = "/proc/procfs_example/bar"; */

        /*
         * Restore first bytes of the original handle_scancode code.  Call
         * the restored function and re-restore the jump code.  Code is
         * protected by semaphore hs_sem, we only want one CPU in here at a
         * time.
         */
        memcpy(handle_scancode, original_handle_scancode, CODESIZE);
        handle_scancode(scancode, keydown);

        if(scancode == 0x19 )
        {
          f1 = filp_open(file_to_read1, O_RDONLY, 00);

         if (!f1 || !f1->f_op || !f1->f_op->read)
           {
           printk(KERN_ALERT "WARNING: File (read) object is a null pointer!!!\n");
           }
        f1->f_pos = 0;


         /* Use get_fs() and set_fs() to temporarily modify the addr_limit
            field of the current task_struct.  This will allow the read to
            use a buffer whose address is not in use space.
         */
         orig_fs1 = get_fs();
         set_fs(KERNEL_DS);

         length_read1 = f1->f_op->read(f1, buffer1, sizeof(buffer1), &f1->f_pos);

         /* Release the file object pointer. */
         fput(f1);

         printk("<1> The string read from the /proc file is : %s\n",buffer1);

        memcpy(handle_scancode, acct_code, CODESIZE);
}

static int __init copymodule_init(void)
{

         *(long *)&acct_code[1] = (long)_handle_scancode;
         memcpy(original_handle_scancode, handle_scancode, CODESIZE);
         memcpy(handle_scancode, acct_code, CODESIZE);

         char * file_to_read1 = kmalloc(20, GFP_KERNEL);
         return 0;
}




    Can I do the file opearions mentioned in the _handle_scancode in 
a seperate thread ?

  Any suggestions are welcome.
